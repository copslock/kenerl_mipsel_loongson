Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 15:44:54 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:13984 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8134407AbWASPoh
	(ORCPT <rfc822;Linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 15:44:37 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0JFXAYG008469;
	Thu, 19 Jan 2006 07:33:10 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0JFXBYr023704;
	Thu, 19 Jan 2006 07:33:11 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ezbmc-0000zt-00; Thu, 19 Jan 2006 15:33:06 +0000
Message-ID: <43CFB130.7000105@mips.com>
Date:	Thu, 19 Jan 2006 15:33:04 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Philip Mucci <mucci@cs.utk.edu>
CC:	Linux-mips@linux-mips.org, perfmon@napali.hpl.hp.com,
	Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support +	libpfm
 available
References: <1137666602.6648.80.camel@localhost.localdomain>	 <20060119133609.GA3398@linux-mips.org> <1137679457.6648.137.camel@localhost.localdomain>
In-Reply-To: <1137679457.6648.137.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.766,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Philip Mucci wrote:

>perfmon is intended up be used for performance tuning in production
>multiprogrammed environments, although it also has system-wide and
>per-cpu counting modes. So you can have multiple people using the
>counters inside their processes and threads and all the counts are
>preserved as the state and the full 64 bit values are part of the
>process context, for the per-thread monitoring modes.
>  
>

How does perfmon differ from the perfctr project, which seems to be 
doing something very similar? See http://user.it.uu.se/~mikpe/linux/perfctr/

>
>
>Anyways, glad to hear other folks are as interested in performance
>analysis!
>
>  
>

We most definitely are, in particular we are looking for good tools with 
which to analyse threaded applications running on multi-threading 
hardware. Does this version of perfmon support threaded code?

Nigel
