Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2018 20:50:44 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994002AbeH3SujsLNeK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2018 20:50:39 +0200
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8B7205F4;
        Thu, 30 Aug 2018 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535655033;
        bh=n9F6AzQMSS0Zpr7/zZgP12eOlMwdFpq3YhYoAGdW49I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPQopcs+BXtSUpQBdZGV9wLiBHCZ+CVI0U7LrivdFFUVkxNbcaDAZhyx5zNndNHtu
         BU4dSdfB2F2ioay1qmrC6tVX1ksWi2jsDG2G6rAIYu1OnhG4YFxOmQQ1V9NramSqtD
         wLKcDeyPViVPwhSYB6W5tqO8/f7pWbXib56JKQlY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0F18B141C3F; Thu, 30 Aug 2018 15:50:27 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:50:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        liu.song.a23@gmail.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v9 4/4] perf probe: Support SDT markers having reference
 counter (semaphore)
Message-ID: <20180830185026.GI6097@kernel.org>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-5-ravi.bangoria@linux.ibm.com>
 <20180830144531.3011e185@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830144531.3011e185@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <acme@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acme@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Em Thu, Aug 30, 2018 at 02:45:31PM -0400, Steven Rostedt escreveu:
> 
> Arnaldo,
> 
> I'm going to be playing with some of the probe code which may conflict
> with these patches, so I would like to pull these in my tree. But this
> patch requires an Acked-by from you before I can pull it in.
> 
> You OK with this?

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Thanks!
> 
> -- Steve
> 
> 
> On Mon, 20 Aug 2018 10:12:50 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
> 
> > With this, perf buildid-cache will save SDT markers with reference
> > counter in probe cache. Perf probe will be able to probe markers
> > having reference counter. Ex,
> > 
> >   # readelf -n /tmp/tick | grep -A1 loop2
> >     Name: loop2
> >     ... Semaphore: 0x0000000010020036
> > 
> >   # ./perf buildid-cache --add /tmp/tick
> >   # ./perf probe sdt_tick:loop2
> >   # ./perf stat -e sdt_tick:loop2 /tmp/tick
> >     hi: 0
> >     hi: 1
> >     hi: 2
> >     ^C
> >      Performance counter stats for '/tmp/tick':
> >                  3      sdt_tick:loop2
> >        2.561851452 seconds time elapsed
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
