Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 19:08:11 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:2469 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225303AbUCPTIK>;
	Tue, 16 Mar 2004 19:08:10 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i2GJ88Qc004994
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Mar 2004 20:08:08 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i2GJ88u6004992;
	Tue, 16 Mar 2004 20:08:08 +0100
Date: Tue, 16 Mar 2004 20:08:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jun Sun <jsun@mvista.com>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] missing _raw_write_trylock
Message-ID: <20040316190808.GA4944@lst.de>
References: <20040316070911.B29232@mvista.com> <40571916.6060502@realitydiluted.com> <20040316175000.GB29803@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316175000.GB29803@mvista.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Mar 16, 2004 at 09:50:00AM -0800, Jun Sun wrote:
> > Are you going to do a non-LLSC, or are we no longer concerned about
> > those?
> > 
> 
> For SMP machines we assume LLSC are present.  This function and its friends 
> for SMP only.

doesn't CONFIG_PREEMPT (*shudder*) need it is aswell?
