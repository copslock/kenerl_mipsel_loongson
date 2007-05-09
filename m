Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2007 17:15:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:3312 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023796AbXEIQO6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2007 17:14:58 +0100
Received: from localhost (p3015-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E3D089805; Thu, 10 May 2007 01:13:37 +0900 (JST)
Date:	Thu, 10 May 2007 01:13:48 +0900 (JST)
Message-Id: <20070510.011348.25233649.anemo@mba.ocn.ne.jp>
To:	guido.zeiger@mailprocessor.de
Cc:	linux-mips@linux-mips.org
Subject: Re: Segmentation Fault from MP3-Player with Etch on Qube2
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de>
References: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 7 May 2007 19:37:40 +0200, Guido Zeiger <guido.zeiger@mailprocessor.de> wrote:
> after reinstalling debian, (now etch , therefore sid) on my Qube2,  
> because of changing to a 2.5" HD (from 3.5") and installing the
> current debian version I got a Segmentation Fault on every usage of a  
> program which should produce sound  :-((
> 
> The programs are
> 
> > mpg123
> > mpg321
> > mp3blaster
> 
> The programs did work with this qube2, soundcard and mp3-file under  
> debian sid,
> but now with etch it didnt work anymore.

There are know problems with PCI soundcard on noncoherent MIPS
platform (including cobalt) and some patches are floating around.  For
example:
http://www.linux-mips.org/archives/linux-mips/2007-04/msg00072.html

This is a long standing issue and I wonder why your soundcard _did_
work with debian sid.  The kernel of sid contains fixes for this
issue?

---
Atsushi Nemoto
