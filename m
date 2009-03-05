Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 21:42:31 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:3977 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S21366146AbZCEVm1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2009 21:42:27 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n25Le59D020448;
	Thu, 5 Mar 2009 16:40:05 -0500
Received: from gateway.sf.frob.com (vpn-14-9.rdu.redhat.com [10.11.14.9])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n25LdvTX022651;
	Thu, 5 Mar 2009 16:40:06 -0500
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id 5012A357B; Thu,  5 Mar 2009 13:39:51 -0800 (PST)
Received: by magilla.sf.frob.com (Postfix, from userid 5281)
	id DC443FC3BF; Thu,  5 Mar 2009 13:39:50 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: Ralf Baechle's message of  Thursday, 5 March 2009 22:36:53 +0100 <20090305213653.GB12355@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
	<49AD6139.60209@caviumnetworks.com>
	<alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk>
	<49B004AA.8050006@caviumnetworks.com>
	<FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com>
	<20090305213653.GB12355@linux-mips.org>
X-Zippy-Says: Is this BOISE??
Message-Id: <20090305213950.DC443FC3BF@magilla.sf.frob.com>
Date:	Thu,  5 Mar 2009 13:39:50 -0800 (PST)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> Somebody could probably earn a medal by writing a single consolidated
> and readable piece of documentation.

generic-abi@googlegroups.com is a place nowadays to find people likely to
be interested in collaborating on better ELF-related documentation.
