Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 12:02:16 +0100 (BST)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:28698 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225371AbTJALCM>;
	Wed, 1 Oct 2003 12:02:12 +0100
Received: from burza.icm.edu.pl (burza.icm.edu.pl [192.168.1.198])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.5/icm) with ESMTP id h91B0Xq6002347;
	Wed, 1 Oct 2003 13:02:02 +0200 (CEST)
Received: from rekin.icm.edu.pl (mail@rekin.icm.edu.pl [192.168.1.132])
	by burza.icm.edu.pl (8.12.9/8.12.9/rzm-2.9.3/icm) with ESMTP id h91AiO1e021524;
	Wed, 1 Oct 2003 12:44:25 +0200 (CEST)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1A4eSx-0005HF-00; Wed, 01 Oct 2003 12:44:19 +0200
Date: Wed, 1 Oct 2003 12:44:14 +0200
From: "Dominik 'Rathann' Mierzejewski" <D.Mierzejewski@icm.edu.pl>
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: Re: [Indy] text console
Message-ID: <20031001104413.GA16929@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org,
	Guido Guenther <agx@sigxcpu.org>
References: <20030926122012.GC19876@icm.edu.pl> <20030930112541.GE26507@icm.edu.pl> <20030930135846.GB761@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930135846.GB761@bogon.ms20.nix>
User-Agent: Mutt/1.3.28i
Return-Path: <D.Mierzejewski@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: D.Mierzejewski@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Tue, Sep 30, 2003 at 03:58:46PM +0200, Guido Guenther wrote:
> On Tue, Sep 30, 2003 at 01:25:42PM +0200, Dominik 'Rathann' Mierzejewski wrote:
> > Doesn't anyone know? Please help or say it's impossible. I'm
> > stuck with 1280x1024@60Hz which is very uncomfortable to my
> > eyes.
> Try the "monitor" PROM variable to switch to 1024x768. See:
>  http://www.parallab.uib.no/SGI_bookshelves/SGI_Admin/books/IA_ConfigOps/sgi_html/ch09.html#LE63851-PARENT

Thanks. I've also found this page:
http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi/0650/bks/SGI_Admin/books/IA_ConfigOps/sgi_html/ch09.html#LE63851-PARENT
which appears to be the same, though.

They say nothing about supported values of the "monitor" variable in
PROM. After googling around I tried to "setenv monitor l", but it
doesn't seem to have any effect. A few people on the usenet say it's
possible to change the resolution only from within IRIX.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>
