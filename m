Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 17:11:01 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57382 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903731Ab1LIQK5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 17:10:57 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB9G7VIw008738;
        Fri, 9 Dec 2011 16:07:31 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB9G7MwM008731;
        Fri, 9 Dec 2011 16:07:22 GMT
Date:   Fri, 9 Dec 2011 16:07:22 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Cong Wang <amwang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Russell King <linux@arm.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        James Bottomley <James.Bottomley@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 61/62] highmem: kill all __kmap_atomic()
Message-ID: <20111209160722.GB30988@linux-mips.org>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-62-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322371662-26166-62-git-send-email-amwang@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7778

On Sun, Nov 27, 2011 at 01:27:41PM +0800, Cong Wang wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
