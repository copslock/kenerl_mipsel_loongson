Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 15:03:20 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:28042 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022890AbXEVODP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2007 15:03:15 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 8D26ABBCF1;
	Tue, 22 May 2007 15:02:13 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1HqU0C-0008A5-KM; Tue, 22 May 2007 14:02:12 +0100
Date:	Tue, 22 May 2007 14:02:12 +0100
To:	sknauert@wesleyan.edu
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070522130212.GA19833@networkno.de>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio> <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

sknauert@wesleyan.edu wrote:
> I've noticed that besides kernel complied from the Debian 2.6.18, I can't
> get any other kernel (vanilla from kernel.org or the separate linux-MIPS
> repository) to boot on my O2.
> 
> If you need beta testers, I can try, but it will take a day or so
> (compiling on the O2 is slow).

If you have a faster Debian system around you may want to try a
cross compiler: http://people.debian.org/~ths/toolchain/


Thiemo
