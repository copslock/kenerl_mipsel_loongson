Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 22:09:21 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:3289 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225002AbVCUWJD>; Mon, 21 Mar 2005 22:09:03 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDV52-00033q-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 23:09:00 +0100
Received: from [80.171.18.61] (helo=d018061.adsl.hansenet.de)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDV52-0001td-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 23:09:00 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Date:	Mon, 21 Mar 2005 23:07:18 +0100
User-Agent: KMail/1.7.1
References: <20050319172101.C23907@flint.arm.linux.org.uk> <200503212151.22059.eckhardt@satorlaser.com> <423F3528.4060907@embeddedalley.com>
In-Reply-To: <423F3528.4060907@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503212307.18304.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Monday 21 March 2005 21:57, Pete Popov wrote:
> Ulrich Eckhardt wrote:
> > I'd give more details, but I'm neither at work nor did I investigate the
> > situation properly. What I remember trying is to add 'console=/dev/ttyS0'
> > or somesuch to the commandline, but couldn't get it to work there.
>
> Well, come on, I know that much works :) Which board and kernel rev?
>

DB1100 derivative running 2.6.something from linux-mips CVS. Maybe it's just 
PEBKAC though, I can't rule that out. Maybe I'll get to trying tomorrow 
again, but it's not on the top of my priorities - that's rooting from CF 
currently.

Uli
