Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 12:38:52 +0100 (BST)
Received: from host51-222-dynamic.2-87-r.retail.telecomitalia.it ([87.2.222.51]:42503
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022559AbXEVLiq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 12:38:46 +0100
Received: from [80.76.68.90] (helo=pc01.bm.loc)
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1HqShM-00050J-0k; Tue, 22 May 2007 13:38:40 +0200
Subject: Re: SGI O2 meth: missing sysfs device symlink
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070522110956.GB29118@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio>
	 <20070516151939.GH19816@deprecation.cyrius.com>
	 <20070516160313.GA3409@bongo.bofh.it>
	 <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
	 <20070517151636.GJ3586@deprecation.cyrius.com>
	 <20070521154726.GE5943@linux-mips.org>
	 <20070522110956.GB29118@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 22 May 2007 13:41:33 +0200
Message-Id: <1179834093.7896.23.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mar, 22/05/2007 alle 12.09 +0100, Ralf Baechle ha scritto:
> On Mon, May 21, 2007 at 04:47:26PM +0100, Ralf Baechle wrote:
> 
> Below patch is meant to cure the problem.  It's against HEAD but should
> apply to somewhat older problems as well.
> 
> I appreciate testing asap so I can try to still push this upstream
> for 2.6.22.
[...]

I may test it against 2.6.18, the standard debian kernel for stable; but
I will be on the console only in two days :-(

Bye,
Giuseppe
