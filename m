Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 12:00:51 +0100 (BST)
Received: from smtp116.plus.mail.re1.yahoo.com ([69.147.102.79]:50358 "HELO
	smtp116.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20025602AbXIFLAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 12:00:43 +0100
Received: (qmail 62601 invoked from network); 6 Sep 2007 11:00:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=GHMmS0rPjgU+BlCPpujBbg0qaKvP2qwFOrXNDhXrXNWIC+FCGP5dz217RChx2MtG9n5KBwD1dsCL5y8C7E0JlzSZHy9YHYKhWQ+w/cye/yw5HX2lPYoZkDD8a2VV4fHPwI5sm9/r/sMiYvR7fLbAPP6w0bI+gwnTM23w/UTRYVs=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp116.plus.mail.re1.yahoo.com with SMTP; 6 Sep 2007 11:00:36 -0000
X-YMail-OSG: u2nDB5kVM1kCkH7S0.pVLFmfFnrAutSF.Dqi.gQprw07MSnUvQE5HN_NVRmdSyu1CwZ1Pp2.SX0xqAH.u8p86G4ABwbOm08ZQMpXwRbrHwxA.b0hfZcNonTwRODvSM7a0dmavAKzVDk-
Date:	Thu, 6 Sep 2007 06:58:15 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Exception while loading kernel
In-Reply-To: <1188481891.6770.22.camel@scarafaggio>
Message-ID: <Pine.LNX.4.64.0709060646120.23362@pixie.tetracon-eng.net>
References: <1188030215.13999.14.camel@scarafaggio>  <20070825152536.GA4499@networkno.de>
  <Pine.SGI.4.60.0708252047260.4891@zeus.tetracon-eng.net> 
 <20070826065054.84c97aef.giuseppe@eppesuigoccas.homedns.org> 
 <Pine.LNX.4.64.0708300931100.14430@pixie.tetracon-eng.net>
 <1188481891.6770.22.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


Hi Giuseppe,

I think I'm getting a clue what is happening to your kernel.  Would you 
please do an "ls -l" in your /boot and tell me exactly HOW BIG your 
System.map and kernel files are?  :)

I took your config as is from the link below and pulled the linux-mips 
source, built it and then made a fascinating discovery when I tried to set 
it up for a boot.

The System.map was OVER 50 MEGS, and the kernel weighed in at a HEFTY 87 
MEGS.

In the various parts of the kernel config, you will see some options for 
the kernel sysmbol table, driver symbols, etc...  Try turning some of 
those off.  In particular, I noticed in your config:

CONFIG_UNUSED_SYMBOLS=y

I suspect you are stressing things that haven't been looked at lately.

Anyway, rebuild with some things turned off, and let us know if your 
little blue box still explodes.

Regards,

-S-

On Thu, 30 Aug 2007, Giuseppe Sacco wrote:

> Il giorno gio, 30/08/2007 alle 09.37 -0400, J. Scott Kasten ha scritto:
>> Giuseppe,
>>
>> Let's review for just a second.  If I understand, you are booting the
>> debian pre-built 2.6.18-4 just fine.  However, any kernel you build
>> yourself seems to be borked.  Correct?
>
> No, I may rebuild 2.6.18 just fine. I even added a few device drivers
> without problems. Lately I tried a more recent kernel, i.e. 2.6.22.2
> 2.6.22.4 and 2.6.23-rc3, bot no one of them seems to boot on an SGI O2.
>
>> You don't need to spam the list with it, but please gzip one or more of
>> your .config files, label them as to kernel version, and email me direct
>> off list.  I would like to try and recreate your problem and see what can
>> be learned here.
>
> you may get the config (for 2.6.22.2 download from linux-mips.org) from
> http://eppesuigoccas.homedns.org/~giuseppe/debian/config-2.6.22.2.bz2
>
> Thanks,
> Giuseppe
>
>
> -- 
> To UNSUBSCRIBE, email to debian-mips-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
>
>
