Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 21:40:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44747 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904273Ab1KIUkh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 21:40:37 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9KeObw022456;
        Wed, 9 Nov 2011 20:40:24 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9KeKuI022451;
        Wed, 9 Nov 2011 20:40:20 GMT
Date:   Wed, 9 Nov 2011 20:40:20 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     linux-mips@linux-mips.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/4] MIPS/Perf-events: update the map of unsupported
 events for 74K
Message-ID: <20111109204020.GB13280@linux-mips.org>
References: <1319453762-12962-1-git-send-email-dczhu@mips.com>
 <1319453762-12962-2-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319453762-12962-2-git-send-email-dczhu@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8155

On Mon, Oct 24, 2011 at 06:55:59PM +0800, Deng-Cheng Zhu wrote:

> Update the raw event info for 74K according to the latest document.

> +/*
> + * MIPS document MD00519 (MIPS32(r) 74K(tm) Processor Core Family Software
> + * User's Manual, Revision 01.05)
> + */
>  #define IS_UNSUPPORTED_74K_EVENT(r, b)					\
> -	((r) == 5 || ((r) >= 135 && (r) <= 137) ||			\
> -	 ((b) >= 10 && (b) <= 12) || (b) == 22 || (b) == 27 ||		\
> -	 (b) == 33 || (b) == 34 || ((b) >= 47 && (b) <= 49) ||		\
> -	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
> -	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
> -	 ((b) >= 64 && (b) <= 127))
> +	((r) == 5 || (r) == 135 || ((b) >= 10 && (b) <= 12) ||		\
> +	 (b) == 27 || (b) == 33 || (b) == 34 || (b) == 47 ||		\
> +	 (b) == 48 || (r) == 178 || (r) == 187 || (b) == 60 ||		\
> +	 (b) == 61 || (r) == 191 || (r) == 71 || (r) == 72 ||		\
> +	 (b) == 73 || ((b) >= 77 && (b) <= 127))

I wonder if such detailed checking of the performance counter
event numbers is really needed?  As long as feeding an bad number only
results in undefined counts of the performance counters I think we may
be better of by not checking the event numbers in detail.  Afair there
are MIPS licensee who have modified the counters to count extra events
so I sense some madness in that direction.

  Ralf
