Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jan 2014 20:53:58 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41397 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817974AbaAGTxzRtG9J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jan 2014 20:53:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C46C78F61;
        Tue,  7 Jan 2014 20:53:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WehhfpP3PCTf; Tue,  7 Jan 2014 20:53:10 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:f92d:7ca2:7eaf:38b4] (unknown [IPv6:2001:470:1f0b:447:f92d:7ca2:7eaf:38b4])
        by hauke-m.de (Postfix) with ESMTPSA id E290C857F;
        Tue,  7 Jan 2014 20:53:02 +0100 (CET)
Message-ID: <52CC5B12.8090305@hauke-m.de>
Date:   Tue, 07 Jan 2014 20:52:50 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Jean-Yves Avenard <jyavenard@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Patch for the "ug" bug
References: <CANpj82+h1a0qBfaaYpqmuL69JpbB+T_z0pg0iL=5JPBvDE9A2w@mail.gmail.com>
In-Reply-To: <CANpj82+h1a0qBfaaYpqmuL69JpbB+T_z0pg0iL=5JPBvDE9A2w@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/07/2012 12:41 PM, Jean-Yves Avenard wrote:
> Hello
> 
> This is my first post here, so hopefully I'm doing it the right way.
> 
> I recently an Asus RT-N66U router, powered by a Broadcom BCM5300. MIPS
> based obviously.
> 
> I am an infrequent committer of the Tomato firmware team.
> One issue was reported that caused quite surprising problems. We call
> it the "ug" bug.
> 
> In a shell:
> cd /tmp
> echo "#!/bin/sh" >bug
> echo 'echo -n $1.' >>bug
> chmod +x bug
> for i in 0 1 2 3 4 5 6 7 8 9; do bug $i; done
> 
> would result in random data being output.
> Typically it would look something like:
> ug.1.ug.3.ug.5.ug.ug.ug.ug.root@RT-N66U:/tmp#
> 
> This issue affects a few other firmware (ddwrt) in particular. This
> doesn't affect Asus stock firmware
> 
> After a short investigation, I ruled out that the problem was either
> in uclibc or busybox and is something related to an issue in the
> kernel
> 
> Looking at the kernel shipped with the Asus, they have made some
> modifications in how pages are initialised...
> 
> The following patch, is a port of the required changes that fix the
> memory corruption exposed by the "ug" bug...
> 
> Let me know if you would like this patch to be submitted differently.
> Not knowing the submit policy, I put it inline, but due to the
> presence of tabs (ugh!) it may not come out properly.
> 
> The patch is for the linux that ships with Tomato obviously, but
> checking the linux git repository, it will apply with minor mod. Let
> me know if you want me to do those mods for you..
> 
> Best regards
> Jean-Yves Avenard

Hi,

this is a little late but I haven't seen this earlier. I just tried your
script and had no problems on my Asus RT-N66U running OpenWrt with
kernel 3.10.24. This problem was either cause by some other non upstream
Broadcom modification or was already fixed in mainline kernel.


root@OpenWrt:~# cd /tmp
root@OpenWrt:/tmp# echo "#!/bin/sh" >bug
root@OpenWrt:/tmp# echo 'echo -n $1.' >>bug
root@OpenWrt:/tmp# cat bug
#!/bin/sh
echo -n $1.
root@OpenWrt:/tmp# chmod +x bug
root@OpenWrt:/tmp# for i in 0 1 2 3 4 5 6 7 8 9; do ./bug $i; done
0.1.2.3.4.5.6.7.8.9.root@OpenWrt:/tmp#
root@OpenWrt:/tmp#

Hauke
