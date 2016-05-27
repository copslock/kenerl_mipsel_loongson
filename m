Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 00:22:48 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:36424 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27036276AbcE0WWrLsLZc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 00:22:47 +0200
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by comcast with SMTP
        id 6Q8MbrEfNO4QF6Q9UbfZz4; Fri, 27 May 2016 22:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1464387764;
        bh=Rh1o1Vz+WZmvVeaYBD7c8YizdPHBLpohJ1I3iqqObbw=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=HfE7A5kMuZVikJHWtU5E8u68eld2RjSyAtLllbZgFEbs0m4SQq1/onGackzHkMrKv
         GaUpEyRelzA52z+6It+kM5QmIBQxFJKGMRZvP4yqNaqhjW7fza1f4xrWIpaei1RDb1
         X85hHCtdBnkHrBqO6IdsloyqniFW2tuwOx+ixl63+jAx+3lVQKlD5HZORVw9hM5oGo
         nAQqBnHPzjNJF9V9PeIBzG9GB7xSAdVTDugzho0f7bWdy2fg+G+wcRC9VK6/iofkH/
         uIq6Rn2Hpey4D/Ai3+W/wWvJMZeA8vyEkEOOa5igkbzGD9RGwSWNsUfOZXMht47o2V
         22dpmMeQQ50rw==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-15v.sys.comcast.net with comcast
        id zaNi1s00B0w5D3801aNiS8; Fri, 27 May 2016 22:22:44 +0000
Subject: Re: THP broken on OCTEON?
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
 <57473996.7030705@gmail.com>
 <20160526192330.GA17985@raspberrypi.musicnaut.iki.fi>
 <5747750E.4090000@gmail.com>
 <20160527171417.GC8755@raspberrypi.musicnaut.iki.fi>
 <86b5dd89-b328-3cb7-0833-8d2fa8aa9f47@gentoo.org>
 <20160527220545.GE8755@raspberrypi.musicnaut.iki.fi>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <c50286a6-2ae1-431e-e539-85ab3bc58a72@gentoo.org>
Date:   Fri, 27 May 2016 18:22:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160527220545.GE8755@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/27/2016 18:05, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, May 27, 2016 at 05:03:06PM -0400, Joshua Kinard wrote:
>> If the binaries on the initramfs are built to any of the MIPS-I to MIPS-IV
>> ISAs, I can test this on my IP27/Onyx2 system as well, though I'll have to
>> build an IP27 kernel and just use the initramfs.
> 
> I built them using --with-arch=octeon+ so they won't work on other HW.
> 
> But there isn't any magic in my binaries. If you have a working 64-bit
> Linux MIPS system (with GCC and make) you can easily try my test case:
> 
> - compile Linux 4.6 with THP (always enabled) and 4KB page size
> 
> 	(preferably using GCC >= 4.9.3)
> 
> - boot with the new kernel & log in
> 
> - execute the following commands:
> 
> 	curl -O http://www.cpan.org/src/5.0/perl-5.22.2.tar.gz
> 	tar xf perl-5.22.2.tar.gz
> 	cd perl-5.22.2
> 	sh Configure -de -Dprefix=/usr -Dcc=gcc && make && make test
> 
> If this passes without odd crashes or hangs (which I highly doubt),
> please post the output of:
> 
> 	grep thp /proc/vmstat
> 

Perl-5.22 is already built on this platform (it's Gentoo), but 5.24 is out, so
I can run that build w/ THP on.  I doubt it will get that far, though.
Assuming it even survives the boot process and gets to runlevel 3, then just
running "emerge" (Gentoo's default package manager) and letting it calculate
dependencies usually trips things up.  The whole system dies in that instance,
but maybe if I boot to single-user and dork around, I can trigger a bus error
or five and still have enough time to grep /proc/vmstat...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
