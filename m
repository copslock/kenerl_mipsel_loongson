Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:16:27 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:37343 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8224861AbTFQMQZ>; Tue, 17 Jun 2003 13:16:25 +0100
Received: from [10.1.1.146] (helo=heck)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 19SFNv-0002hS-Gm
	for linux-mips@linux-mips.org; Tue, 17 Jun 2003 14:16:23 +0200
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 19SFNu-0000xT-00
	for <linux-mips@linux-mips.org>; Tue, 17 Jun 2003 14:16:22 +0200
Date: Tue, 17 Jun 2003 14:16:22 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Re: Building a stand-alone FS on a very limited flash (newbie question)
Message-ID: <20030617121622.GH1215@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
References: <20030610131519.47A8BC5FD7@atlas.denx.de> <3EEC9513.80905@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEC9513.80905@galileo.co.il>
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Baruch Chaikin wrote:
> 
> Another question is the file system itself.  What is the recommendation 
> here - JFFS, CRAMFS, anything else?...

jffs if you need read/write, cramfs or squashfs for read-only.

stock cramfs has endianness problems (mkcramfs must run on same
endianness as kernel), but patches exist.

http://sourceforge.net/projects/squashfs/
http://sourceforge.net/projects/cramfs/

Johannes
