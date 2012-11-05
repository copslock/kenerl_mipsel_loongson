Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 22:33:28 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60698 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825968Ab2KEVd05ClCa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 22:33:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 8656AD86;
        Mon,  5 Nov 2012 22:33:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RNxbmaIO2loQ; Mon,  5 Nov 2012 22:33:10 +0100 (CET)
Received: from [192.168.178.21] (ppp-188-174-75-12.dynamic.mnet-online.de [188.174.75.12])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 2E2A5D84;
        Mon,  5 Nov 2012 22:32:54 +0100 (CET)
Message-ID: <509830A9.5050205@metafoo.de>
Date:   Mon, 05 Nov 2012 22:33:29 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>
CC:     linux-mips@linux-mips.org
Subject: Re: Broken readdir() since 3.5 for ext3 on mips-n32
References: <20121102183828.GX2052@vicerveza.homeunix.net> <20121104232119.GF2052@vicerveza.homeunix.net> <20121105073221.GG2052@vicerveza.homeunix.net> <20121105212019.GN2052@vicerveza.homeunix.net>
In-Reply-To: <20121105212019.GN2052@vicerveza.homeunix.net>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/05/2012 10:20 PM, Lluís Batlle i Rossell wrote:
> Hello,
> 
> with the help of Lars on irc, we've tracked down the issue to a broken readdir()
> in ext3 in n32, introduced in the kernel 3.5 by this commit:
> d7dab39b6e16d5eea78ed3c705d2a2d0772b4f06
> 
> That renders ext3 quite useless in mips n32.
> 
> In a kernel after that commit, the example program in the 'getdents' man page
> returns this:
> [root@fu2:~/readdir]# ./getdents 
> --------------- nread=116 ---------------
> i-node#  file type  d_reclen  d_off   d_name
>     3694  regular      20 1780583312  prova.c
>  1037850  regular      24 -985956880  getdents.c
>  1037848  directory    16 -1999547753  .
>  1037849  regular      20  222381689  getdents
>   778241  directory    16 -1849228342  ..
>     3647  regular      20         -1  prova
> 
> 
> I took Lars suggestion of applying the patch I attach (forcing ext3 to think it
> is a 32-bit system), and then all works. init (upstart) doesn't deadlock anymore, readdir() works fine, and the getdents info looks right:
> [root@fu2:~/readdir]# ./getdents 
> --------------- nread=116 ---------------
> i-node#  file type  d_reclen  d_off   d_name
>     3694  regular      20  334739480  prova.c
>  1037850  regular      24  473707228  getdents.c
>  1037848  directory    16  824759881  .
>  1037849  regular      20  875064456  getdents
>   778241  directory    16 1524836457  ..
>     3647  regular      20 2147483647  prova
> 
> How to solve this, I don't know. But it seems that ext3 thinks that mips-n32
> programs can eat some 64-bit words in d_off.

I think the issue here is that is_compat_task() returns false if both o32 and
n32 support are built into the kernel.

is_compat_task() is defined is

static inline int is_compat_task(void)
{
    return test_thread_flag(TIF_32BIT);
}

and TIF_32BIT is defined as

#ifdef CONFIG_MIPS32_O32
#define TIF_32BIT TIF_32BIT_REGS
#elif defined(CONFIG_MIPS32_N32)
#define TIF_32BIT _TIF_32BIT_ADDR
#endif /* CONFIG_MIPS32_O32 */

the n32 personality only sets TIF_32BIT_ADDR, so the test will fail. Also
shouldn't it be '#define TIF_32BIT TIF_32BIT_ADDR' instead of '#define
TIF_32BIT _TIF_32BIT_ADDR'?

> 
> Regards,
> Lluís.
> 
> On Mon, Nov 05, 2012 at 08:32:21AM +0100, Lluís Batlle i Rossell wrote:
>> This same issue below happens to me in 3.5.7 too. So, the change is somewhere
>> between 3.4 and 3.5.
>>
>> Regards,
>> Lluís.
>>
>> On Mon, Nov 05, 2012 at 12:21:19AM +0100, Lluís Batlle i Rossell wrote:
>>> I've investigated better the issue.
>>>
>>> I found that, in 3.4 vs 3.6.4, the behaviour that changed is that of readdir().
>>>
>>> Using the same userland binaries, I've run a little program in both kernels:
>>> -------- prova.c
>>> #include <sys/types.h>
>>> #include <dirent.h>
>>>
>>> int main() {
>>>         DIR *d = opendir("/etc/init");
>>>
>>>         if (d == NULL) {
>>>                 fprintf(stderr, "d NULL\n");
>>>                 return -1;
>>>         }
>>>
>>>         struct dirent *ent;
>>>         ent = readdir(d);
>>>
>>>         if (ent == NULL) {
>>>                 fprintf(stderr, "ent NULL\n");
>>>                 return -1;
>>>         }
>>> }
>>> -----------
>>>
>>>
>>> This program does not print anything on 3.4, but on 3.6, it prints "ent NULL".
>>>
>>> In both cases, /etc/init is full of symlinks, like this (from a script session
>>> in 3.6.4):
>>> -------
>>> S'ha iniciat l'execució de script a dl 05 nov 2012 00:16:53 CET
>>> sh-4.2# ./prova
>>> ent NULL
>>> sh-4.2# ls -ld /etc/init
>>> drwxr-xr-x 2 root root 4096  5 nov 00:12 /etc/init
>>> sh-4.2# ls -l /etc/init
>>> total 0
>>> lrwxrwxrwx 1 root root 25  5 nov 00:12 atd.conf -> /etc/static/init/atd.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 boot.conf -> /etc/static/init/boot.conf
>>> lrwxrwxrwx 1 root root 40  5 nov 00:12 control-alt-delete.conf -> /etc/static/init/control-alt-delete.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 cron.conf -> /etc/static/init/cron.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 dbus.conf -> /etc/static/init/dbus.conf
>>> lrwxrwxrwx 1 root root 28  5 nov 00:12 dhcpcd.conf -> /etc/static/init/dhcpcd.conf
>>> lrwxrwxrwx 1 root root 37  5 nov 00:12 emergency-shell.conf -> /etc/static/init/emergency-shell.conf
>>> lrwxrwxrwx 1 root root 37  5 nov 00:12 invalidate-nscd.conf -> /etc/static/init/invalidate-nscd.conf
>>> lrwxrwxrwx 1 root root 25  5 nov 00:12 kbd.conf -> /etc/static/init/kbd.conf
>>> lrwxrwxrwx 1 root root 27  5 nov 00:12 klogd.conf -> /etc/static/init/klogd.conf
>>> lrwxrwxrwx 1 root root 25  5 nov 00:12 lvm.conf -> /etc/static/init/lvm.conf
>>> lrwxrwxrwx 1 root root 30  5 nov 00:12 mountall.conf -> /etc/static/init/mountall.conf
>>> lrwxrwxrwx 1 root root 36  5 nov 00:12 mountall-ip-up.conf -> /etc/static/init/mountall-ip-up.conf
>>> lrwxrwxrwx 1 root root 34  5 nov 00:12 mount-failed.conf -> /etc/static/init/mount-failed.conf
>>> lrwxrwxrwx 1 root root 32  5 nov 00:12 networking.conf -> /etc/static/init/networking.conf
>>> lrwxrwxrwx 1 root root 40  5 nov 00:12 network-interfaces.conf -> /etc/static/init/network-interfaces.conf
>>> lrwxrwxrwx 1 root root 32  5 nov 00:12 nix-daemon.conf -> /etc/static/init/nix-daemon.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 nscd.conf -> /etc/static/init/nscd.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 ntpd.conf -> /etc/static/init/ntpd.conf
>>> lrwxrwxrwx 1 root root 30  5 nov 00:12 runlevel.conf -> /etc/static/init/runlevel.conf
>>> lrwxrwxrwx 1 root root 30  5 nov 00:12 shutdown.conf -> /etc/static/init/shutdown.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 sshd.conf -> /etc/static/init/sshd.conf
>>> lrwxrwxrwx 1 root root 29  5 nov 00:12 syslogd.conf -> /etc/static/init/syslogd.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty1.conf -> /etc/static/init/tty1.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty2.conf -> /etc/static/init/tty2.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty3.conf -> /etc/static/init/tty3.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty4.conf -> /etc/static/init/tty4.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty5.conf -> /etc/static/init/tty5.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 tty6.conf -> /etc/static/init/tty6.conf
>>> lrwxrwxrwx 1 root root 26  5 nov 00:12 udev.conf -> /etc/static/init/udev.conf
>>> lrwxrwxrwx 1 root root 33  5 nov 00:12 udevtrigger.conf -> /etc/static/init/udevtrigger.conf
>>> sh-4.2# exit
>>>
>>> S'ha finalitzat l'execució de script a dl 05 nov 2012 00:17:22 CET
>>> --------
>>>
>>>
>>>
>>>
>>> On Fri, Nov 02, 2012 at 07:38:28PM +0100, Lluís Batlle i Rossell wrote:
>>>> Hello,
>>>>
>>>> updating my kernel from 3.4.2 to 3.6.4, I've noticed that upstart deadlocks at
>>>> the very start. Stracing, I think it has to do with INOTIFY, because it
>>>> deadlocks very early and little more has been done then.
>>>>
>>>> Going 'back' to 3.4.16, makes upstart work fine. I've not tested middle kernels.
>>>>
>>>> I've seen this only on the fuloong minipc (mips n64), but I've done similar
>>>> steps with the same distributions on armv5tel, i686 and x86_64, and there all
>>>> works fine.
>>>>
>>>> Does anybody know of anything broken around inotify, between 3.4 and 3.6 linux
>>>> mips?
>>>>
>>>> Any suggestion on what kernel change could have related to this, and so, get a
>>>> clue about what middle version to test?
>>>>
>>>> Regards,
>>>> Lluís.
> 
