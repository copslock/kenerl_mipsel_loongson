Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 00:46:57 +0200 (CEST)
Received: from perches-mx.perches.com ([206.117.179.246]:34726 "EHLO
        labridge.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6835055Ab3F0WqeIHNSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 00:46:34 +0200
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.152])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 21120111; Thu, 27 Jun 2013 15:46:29 -0700
Message-ID: <1372373188.2060.32.camel@joe-AO722>
Subject: Re: [PATCH v2] mm: module_alloc: check if size is 0
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Date:   Thu, 27 Jun 2013 15:46:28 -0700
In-Reply-To: <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
         <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
         <20130627093917.GQ7171@linux-mips.org>
         <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Thu, 2013-06-27 at 15:23 -0700, Andrew Morton wrote:
> On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:
[]
> Veli-Pekka's original patch would be neater if we were to add a new
> 
> void *__vmalloc_node_range_zero_size_ok(<args>)
> {
> 	if (size == 0)
> 		return NULL;

I believe you mean
		return ZERO_SIZE_PTR;
