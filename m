Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 17:50:06 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63735 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225309AbUCPRuE>;
	Tue, 16 Mar 2004 17:50:04 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2GHo1x6029883;
	Tue, 16 Mar 2004 09:50:01 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2GHo0e7029874;
	Tue, 16 Mar 2004 09:50:00 -0800
Date: Tue, 16 Mar 2004 09:50:00 -0800
From: Jun Sun <jsun@mvista.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH 2.6] missing _raw_write_trylock
Message-ID: <20040316175000.GB29803@mvista.com>
References: <20040316070911.B29232@mvista.com> <40571916.6060502@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40571916.6060502@realitydiluted.com>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 16, 2004 at 10:11:18AM -0500, Steven J. Hill wrote:
> Jun Sun wrote:
> >Please help me reviewing the code, because inline assembly bug is
> >always tricky and miserable.  
> >
> Are you going to do a non-LLSC, or are we no longer concerned about
> those?
> 

For SMP machines we assume LLSC are present.  This function and its friends 
for SMP only.

Jun
