Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 11:42:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35117 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491107Ab0AKKm2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2010 11:42:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0BAgJh0015727;
        Mon, 11 Jan 2010 11:42:19 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0BAgFNh015725;
        Mon, 11 Jan 2010 11:42:15 +0100
Date:   Mon, 11 Jan 2010 11:42:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Anton Blanchard <anton@samba.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 4/6] mips: cpumask_of_node() should handle -1 as a node
Message-ID: <20100111104215.GF13886@linux-mips.org>
References: <20100106045509.245662398@samba.org>
 <20100106045525.207405499@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100106045525.207405499@samba.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6966

On Wed, Jan 06, 2010 at 03:55:13PM +1100, Anton Blanchard wrote:

> Subject: [patch 4/6] mips: cpumask_of_node() should handle -1 as a node

Thanks, applied!

  Ralf
