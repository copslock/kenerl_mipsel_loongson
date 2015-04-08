Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 11:59:04 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34427 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010412AbbDHJ7DfCAWr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Apr 2015 11:59:03 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id BAD418EA30;
        Wed,  8 Apr 2015 09:59:01 +0000 (UTC)
Received: from krava.redhat.com (vpn-202-41.tlv.redhat.com [10.35.202.41])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id t389wtFP031197;
        Wed, 8 Apr 2015 05:58:56 -0400
Date:   Wed, 8 Apr 2015 11:58:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 2/2] perf tools: Hook up MIPS unwind and dwarf-regs in
 the Makefile
Message-ID: <20150408095853.GC14284@krava.redhat.com>
References: <cover.1428450297.git.ralf@linux-mips.org>
 <f43306ea57733a711b66a92a5e5f17fd1a6f3f8a.1428450297.git.ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43306ea57733a711b66a92a5e5f17fd1a6f3f8a.1428450297.git.ralf@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <jolsa@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jolsa@redhat.com
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

On Wed, Apr 08, 2015 at 01:58:47AM +0200, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Define a new symbol (ARCH_SUPPORTS_LIBUNWIND) in config/Makefile.
> Use this from x86 and MIPS to gate testing of libunwind.

hum.. hows ARCH_SUPPORTS_LIBUNWIND being used?
I dont see it.. are there more patches? ;-)

jirka
