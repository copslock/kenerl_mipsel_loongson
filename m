Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 01:14:01 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:56227 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20037809AbXBPBN4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Feb 2007 01:13:56 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1G1AahB002841
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Feb 2007 17:10:36 -0800
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l1G1Aa7H015113;
	Thu, 15 Feb 2007 17:10:36 -0800
Date:	Thu, 15 Feb 2007 17:10:35 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Message-Id: <20070215171035.83918aae.akpm@linux-foundation.org>
In-Reply-To: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca>
References: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 15 Feb 2007 13:26:29 -0600
Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> +			status = *(volatile u32 *)up->port.private_data;

It distresses me that this patch uses a variable which this patch
doesn't initialise anywhere.  It isn't complete.

The sub-driver code whch sets up this field shuld be included in the
patch, no?
