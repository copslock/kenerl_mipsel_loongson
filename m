Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 19:29:01 +0100 (BST)
Received: from web31514.mail.mud.yahoo.com ([68.142.198.143]:28847 "HELO
	web31514.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038620AbWIGS27 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 19:28:59 +0100
Received: (qmail 25364 invoked by uid 60001); 7 Sep 2006 18:28:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sgAcF+3XQPGQZPRkzYRJ1QkEYjoDQRd9qJ1UE3/leF90qlex9B1kSHIdRji0IBM0HpIB3s2ozEo3xwd5y0Z5Wv1zcsiGMC3mXBjjlaVoDftrHcm/w9sgIetW2t2TO7dssPhjxtwJE1YFBK/fqX3x2aDpzXlDUiEbmPXbxpFCcYc=  ;
Message-ID: <20060907182853.25362.qmail@web31514.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31514.mail.mud.yahoo.com via HTTP; Thu, 07 Sep 2006 11:28:53 PDT
Date:	Thu, 7 Sep 2006 11:28:53 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Resetting a Broadcom in software
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060907010324.GA17536@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Ok, I have the information...

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> There are sub-types to pass 2 but I don't know how
> to identify those.
> Probably by the content of the wafer id register or
> something like that.

Sentosa (which resets on running the program):

Wafer ID: 92cee019 Lot 9395 Wafer 23
Mfg Test: Bin A
CPU: 1040102

Linux' /proc/cpuinfo says a little more:

cpu model               : SiByte SB1 V0.2
(lots of uninteresting stuff)
ASEs installed          : mdmx

Swarm (which does not reset on running the program):
Wafer ID: 5838e019 Lot 5646 Wafer 7
Mfg Test: Bin A
CPU: 1040102

Linux' /proc/cpuinfo:

cpu model               : SiByte SB1 V0.2 FPU 0.2
(more boring stuff)
ASEs installed          : mdmx mips3d


On an aside, can anyone suggest some good values for
Linux' "machine selection" kernel config menu? Well, I
guess it's not really an aside as it's just occurred
to me that the difference in wafer may require
tweaking beyond just setting the system type. Also, if
anyone knows of "must set" options elsewhere, I'd
appreciate knowing.

I know some:

1. Pages are 4K, unless the big page patch is appplied
(try saying that three times quickly).
2. The Broadcom tech docs don't document the presence
of multi-threading in the CPU, so I'm assuming that
has to be off.
3. Most of the profiling options seem to barf in ways
that can only be described as spectacular.
4. I don't know which debug options are needed or not
needed, but certain apparently random permutations
result in a working kernel, others will cause it to
explode violently on bootup.

Some third-party patches work... ...when the
maintainer keeps them up-to-date. Mingo's -rt patches
go in clean and seem to run fine, for example, but I'm
cautious applying 2.6.17 patches to a 2.6.18-rc6
kernel (the current MIPSified Linux kernel in git).

Unfortunately, a lot of the really really good 3rd
party patches are for Intel processors only, and I'm
reluctant to keep a port in sync, partly for reasons
of time but also because I'm not convinced I
understand the mechanisms used by the truly
exceptional stuff well enough to implement on a
platform I'm still figuring out some of the
characteristics of.

Jonathan

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
