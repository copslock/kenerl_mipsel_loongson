Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2007 13:19:12 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:6614 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20025829AbXFBMTK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Jun 2007 13:19:10 +0100
Received: (qmail 19272 invoked by uid 101); 2 Jun 2007 12:19:01 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 2 Jun 2007 12:19:01 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l52CIuS0008947
	for <linux-mips@linux-mips.org>; Sat, 2 Jun 2007 05:19:01 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNWZ3TJ>; Sat, 2 Jun 2007 05:18:56 -0700
Message-ID: <340C71CD25A7EB49BFA81AE8C839266706C3B3@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Sagar Borikar <Sagar_Borikar@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: call graph support in oprofile for MIPS
Date:	Sat, 2 Jun 2007 05:18:34 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Sagar_Borikar@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Sagar_Borikar@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Folks,
 
We are interested in using call graph feature in oprofile for RM9000 platform.
Could you please let me know status and current efforts involved in this. Since I could see that backtracking feature is supported in ARM, x86 and ia64 as well but not for MIPS. 
If anybody has done some work on this, I can continue from that state.
Please let me know.
 
Thanks in advance,
 
Sagar Borikar
