Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2005 19:21:57 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:32195 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133411AbVJKSVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Oct 2005 19:21:41 +0100
Received: (qmail 27104 invoked by uid 101); 11 Oct 2005 18:21:34 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 11 Oct 2005 18:21:34 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j9BILPLr027837
	for <linux-mips@linux-mips.org>; Tue, 11 Oct 2005 11:21:34 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <RMQN2D0T>; Tue, 11 Oct 2005 11:21:36 -0700
Message-ID: <5C1FD43E5F1B824E83985A74F396286E5E9528@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: git, rsync, and firewalls...
Date:	Tue, 11 Oct 2005 11:23:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Don_Hiatt@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Don_Hiatt@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Any ideas on how you would go about doing the initial git clone if
rsync is blocked? Of course I could do it at home and then carry
it back but all those bits get awful heavy.. :) Is it possible to
use wget to grab the repository?

Cheers,

don
