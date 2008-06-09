Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 13:33:43 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:1788 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20031324AbYFIMdl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2008 13:33:41 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m59CXVfa026696;
	Mon, 9 Jun 2008 14:33:31 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m59CXUuf026692;
	Mon, 9 Jun 2008 13:33:30 +0100
Date:	Mon, 9 Jun 2008 13:33:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Chen, Huacai" <huacai.chen@intel.com>
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]modify the MIPS CPU classfication
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01404341@pdsmsx415.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.55.0806091330560.26593@cliff.in.clinika.pl>
References: <42DFA526FC41B1429CE7279EF83C6BDC01404341@pdsmsx415.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 9 Jun 2008, Chen, Huacai wrote:

> The company ID of Loongson1/Loongson2 is PRID_COMP_LEGACY, but they were
> classified in the list whoes company ID is  PRID_COMP_MIPS. This patch
> move them to the right place.

 Note the list is currently sorted numerically and meant to stay such.  
Please update your patch accordingly.

  Maciej
