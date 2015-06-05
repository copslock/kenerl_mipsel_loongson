Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:46:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51013 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007525AbbFEIqwSDHtO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jun 2015 10:46:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t558kjWL030883;
        Fri, 5 Jun 2015 10:46:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t558kh9r030882;
        Fri, 5 Jun 2015 10:46:43 +0200
Date:   Fri, 5 Jun 2015 10:46:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiang Liu <jiang.liu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jonas Gorski <jogo@openwrt.org>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        Christoph Lameter <cl@linux.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [Patch v3 21/36] mips, irq: Use access helper
 irq_data_get_affinity_mask()
Message-ID: <20150605084642.GX26432@linux-mips.org>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
 <1433145945-789-22-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433145945-789-22-git-send-email-jiang.liu@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jun 01, 2015 at 04:05:30PM +0800, Jiang Liu wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
