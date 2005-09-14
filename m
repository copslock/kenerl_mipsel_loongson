Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 14:02:44 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:48612 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225201AbVINNC0>;
	Wed, 14 Sep 2005 14:02:26 +0100
Received: from port-195-158-179-11.dynamic.qsc.de ([195.158.179.11] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1EFWu3-00045x-00; Wed, 14 Sep 2005 15:02:19 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EFWtj-0001ug-8x; Wed, 14 Sep 2005 15:01:59 +0200
Date:	Wed, 14 Sep 2005 15:01:54 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Git
Message-ID: <20050914130154.GQ32506@hattusa.textio>
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org> <20050914095858.GD23161@lug-owl.de> <20050914123750.GL3224@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914123750.GL3224@linux-mips.org>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
[snip]
> > SVN
> > 	Not distributed, easy to use.  Though there's a different
> > 	frontend with distribution capabilities. Personally, SVN feels
> > 	like CVS with it's major conceptual problems fixed.
> 
> And plenty of reports about database corruption that are not terribly old
> so I'd feel uneasy to keep the crown jewels there.

This was related to the underlying berkeleydb, the switch to fsfs
fixed that. (SVN is used for several larger Debian projects like
its Xfree86/XOrg tree, it holds up quite well there.)

Btw, there's also SVK which implements a distributed system on top
of SVN. Some general comparision of the various SCMs:

http://linuxmafia.com/faq/Apps/scm.html
http://www.dwheeler.com/essays/scm.html


Thiemo
