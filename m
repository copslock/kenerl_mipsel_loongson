Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 00:21:32 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52264 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6825931Ab2KDXV35lJH6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Nov 2012 00:21:29 +0100
Received: from 210.34.21.95.dynamic.jazztel.es ([95.21.34.210] helo=mail.viric.name)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1TV9VL-000FFu-LQ
        for linux-mips@linux-mips.org; Sun, 04 Nov 2012 23:21:24 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 450632D97F3; Mon,  5 Nov 2012 00:21:20 +0100 (CET)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 95.21.34.210
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/PzvK1egHYKY1+LuwkI7Q9
Date:   Mon, 5 Nov 2012 00:21:19 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Subject: Failing readdir() on 3.6 (was: Failing INOTIFY in 3.6.x?)
Message-ID: <20121104232119.GF2052@vicerveza.homeunix.net>
References: <20121102183828.GX2052@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20121102183828.GX2052@vicerveza.homeunix.net>
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 8BIT
X-archive-position: 34865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
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

I've investigated better the issue.

I found that, in 3.4 vs 3.6.4, the behaviour that changed is that of readdir().

Using the same userland binaries, I've run a little program in both kernels:
-------- prova.c
#include <sys/types.h>
#include <dirent.h>

int main() {
        DIR *d = opendir("/etc/init");

        if (d == NULL) {
                fprintf(stderr, "d NULL\n");
                return -1;
        }

        struct dirent *ent;
        ent = readdir(d);

        if (ent == NULL) {
                fprintf(stderr, "ent NULL\n");
                return -1;
        }
}
-----------


This program does not print anything on 3.4, but on 3.6, it prints "ent NULL".

In both cases, /etc/init is full of symlinks, like this (from a script session
in 3.6.4):
-------
S'ha iniciat l'execució de script a dl 05 nov 2012 00:16:53 CET
sh-4.2# ./prova
ent NULL
sh-4.2# ls -ld /etc/init
drwxr-xr-x 2 root root 4096  5 nov 00:12 /etc/init
sh-4.2# ls -l /etc/init
total 0
lrwxrwxrwx 1 root root 25  5 nov 00:12 atd.conf -> /etc/static/init/atd.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 boot.conf -> /etc/static/init/boot.conf
lrwxrwxrwx 1 root root 40  5 nov 00:12 control-alt-delete.conf -> /etc/static/init/control-alt-delete.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 cron.conf -> /etc/static/init/cron.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 dbus.conf -> /etc/static/init/dbus.conf
lrwxrwxrwx 1 root root 28  5 nov 00:12 dhcpcd.conf -> /etc/static/init/dhcpcd.conf
lrwxrwxrwx 1 root root 37  5 nov 00:12 emergency-shell.conf -> /etc/static/init/emergency-shell.conf
lrwxrwxrwx 1 root root 37  5 nov 00:12 invalidate-nscd.conf -> /etc/static/init/invalidate-nscd.conf
lrwxrwxrwx 1 root root 25  5 nov 00:12 kbd.conf -> /etc/static/init/kbd.conf
lrwxrwxrwx 1 root root 27  5 nov 00:12 klogd.conf -> /etc/static/init/klogd.conf
lrwxrwxrwx 1 root root 25  5 nov 00:12 lvm.conf -> /etc/static/init/lvm.conf
lrwxrwxrwx 1 root root 30  5 nov 00:12 mountall.conf -> /etc/static/init/mountall.conf
lrwxrwxrwx 1 root root 36  5 nov 00:12 mountall-ip-up.conf -> /etc/static/init/mountall-ip-up.conf
lrwxrwxrwx 1 root root 34  5 nov 00:12 mount-failed.conf -> /etc/static/init/mount-failed.conf
lrwxrwxrwx 1 root root 32  5 nov 00:12 networking.conf -> /etc/static/init/networking.conf
lrwxrwxrwx 1 root root 40  5 nov 00:12 network-interfaces.conf -> /etc/static/init/network-interfaces.conf
lrwxrwxrwx 1 root root 32  5 nov 00:12 nix-daemon.conf -> /etc/static/init/nix-daemon.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 nscd.conf -> /etc/static/init/nscd.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 ntpd.conf -> /etc/static/init/ntpd.conf
lrwxrwxrwx 1 root root 30  5 nov 00:12 runlevel.conf -> /etc/static/init/runlevel.conf
lrwxrwxrwx 1 root root 30  5 nov 00:12 shutdown.conf -> /etc/static/init/shutdown.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 sshd.conf -> /etc/static/init/sshd.conf
lrwxrwxrwx 1 root root 29  5 nov 00:12 syslogd.conf -> /etc/static/init/syslogd.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty1.conf -> /etc/static/init/tty1.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty2.conf -> /etc/static/init/tty2.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty3.conf -> /etc/static/init/tty3.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty4.conf -> /etc/static/init/tty4.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty5.conf -> /etc/static/init/tty5.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 tty6.conf -> /etc/static/init/tty6.conf
lrwxrwxrwx 1 root root 26  5 nov 00:12 udev.conf -> /etc/static/init/udev.conf
lrwxrwxrwx 1 root root 33  5 nov 00:12 udevtrigger.conf -> /etc/static/init/udevtrigger.conf
sh-4.2# exit

S'ha finalitzat l'execució de script a dl 05 nov 2012 00:17:22 CET
--------




On Fri, Nov 02, 2012 at 07:38:28PM +0100, Lluís Batlle i Rossell wrote:
> Hello,
> 
> updating my kernel from 3.4.2 to 3.6.4, I've noticed that upstart deadlocks at
> the very start. Stracing, I think it has to do with INOTIFY, because it
> deadlocks very early and little more has been done then.
> 
> Going 'back' to 3.4.16, makes upstart work fine. I've not tested middle kernels.
> 
> I've seen this only on the fuloong minipc (mips n64), but I've done similar
> steps with the same distributions on armv5tel, i686 and x86_64, and there all
> works fine.
> 
> Does anybody know of anything broken around inotify, between 3.4 and 3.6 linux
> mips?
> 
> Any suggestion on what kernel change could have related to this, and so, get a
> clue about what middle version to test?
> 
> Regards,
> Lluís.
