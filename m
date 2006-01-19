Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 15:38:30 +0000 (GMT)
Received: from shu.cs.utk.edu ([160.36.56.39]:8870 "EHLO shu.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S8134404AbWASPiL (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 15:38:11 +0000
Received: from localhost (shu [127.0.0.1])
	by shu.cs.utk.edu (Postfix) with ESMTP id 89BDC13B5A;
	Thu, 19 Jan 2006 10:41:58 -0500 (EST)
Received: from shu.cs.utk.edu ([127.0.0.1])
 by localhost (shu [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11222-10; Thu, 19 Jan 2006 10:41:57 -0500 (EST)
Received: from dhcp-221-85.pdc.kth.se (dhcp-221-85.pdc.kth.se [130.237.221.85])
	by shu.cs.utk.edu (Postfix) with ESMTP id 81A3413B51;
	Thu, 19 Jan 2006 10:41:56 -0500 (EST)
Subject: Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support
	+	libpfm available
From:	Philip Mucci <mucci@cs.utk.edu>
To:	Nigel Stephens <nigel@mips.com>
Cc:	Linux-mips@linux-mips.org, perfmon@napali.hpl.hp.com,
	Stephane Eranian <eranian@hpl.hp.com>
In-Reply-To: <43CFB130.7000105@mips.com>
References: <1137666602.6648.80.camel@localhost.localdomain>
	 <20060119133609.GA3398@linux-mips.org>
	 <1137679457.6648.137.camel@localhost.localdomain>
	 <43CFB130.7000105@mips.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Thu, 19 Jan 2006 16:41:54 +0100
Message-Id: <1137685314.6648.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hi Nigel,

There is a much more detailed discussion to be found on the perfctr
mailing list...we all worked through that when deciding on perfmon. I
have been a big advocate in the past for perfctr especially since it
played such an important part of the PAPI work. But in a nutshell:

- kernel level event multiplexing
- buffered IP sampling and profiling
- remote (third party) monitoring
- support for event address features through sampling like IA64, PIV and
PPC64 support
- support for randomization

To name the most important ones...

Stefane has worked with us, and Mikael P, to make sure that perfmon
provides everything that Perfctr did...one notable addition was support
for mmaped counters where you can read the full 64 bit quantity in user
mode...Not possible on MIPS64 though...darn privileged mfc
instructions...that's avail on the 10/12/14K and probably others of the
MIPS line...

Check this link:
http://sourceforge.net/mailarchive/message.php?msg_id=12829209

Regards,

Phil


On Thu, 2006-01-19 at 15:33 +0000, Nigel Stephens wrote:
> 
> Philip Mucci wrote:
> 
> >perfmon is intended up be used for performance tuning in production
> >multiprogrammed environments, although it also has system-wide and
> >per-cpu counting modes. So you can have multiple people using the
> >counters inside their processes and threads and all the counts are
> >preserved as the state and the full 64 bit values are part of the
> >process context, for the per-thread monitoring modes.
> >  
> >
> 
> How does perfmon differ from the perfctr project, which seems to be 
> doing something very similar? See http://user.it.uu.se/~mikpe/linux/perfctr/
> 
> >
> >
> >Anyways, glad to hear other folks are as interested in performance
> >analysis!
> >
> >  
> >
> 
> We most definitely are, in particular we are looking for good tools with 
> which to analyse threaded applications running on multi-threading 
> hardware. Does this version of perfmon support threaded code?
> 
> Nigel
