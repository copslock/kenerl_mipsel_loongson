Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 22:59:33 +0100 (BST)
Received: from smtp.osdl.org ([65.172.181.4]:910 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8133482AbWDNV7Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Apr 2006 22:59:25 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3EM48tH031292
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Apr 2006 15:04:09 -0700
Received: from akpm.pao.digeo.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k3EM3vnJ010157;
	Fri, 14 Apr 2006 15:03:59 -0700
Date:	Fri, 14 Apr 2006 15:06:25 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	Steven Rostedt <rostedt@goodmis.org>
Cc:	linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
	tglx@linutronix.de, ak@suse.de, mj@atrey.karlin.mff.cuni.cz,
	bjornw@axis.com, schwidefsky@de.ibm.com,
	benedict.gaster@superh.com, lethal@linux-sh.org, chris@zankel.net,
	marc@tensilica.com, joe@tensilica.com, davidm@hpl.hp.com,
	rth@twiddle.net, spyro@f2s.com, starvik@axis.com,
	tony.luck@intel.com, linux-ia64@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-Id: <20060414150625.3ba369d2.akpm@osdl.org>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Example:
> 
>  DEFINE_PER_CPU(int, myint);
> 
>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.

Suppose two .c files each have

	DEFINE_STATIC_PER_CPU(myint)

Do we end up with two per_cpu_offset__myint's in the same section?
