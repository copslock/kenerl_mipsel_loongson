Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 02:50:05 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33019 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008060AbbLABuDEmpNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2015 02:50:03 +0100
Received: by pabfh17 with SMTP id fh17so209604027pab.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 17:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X4WNCAq9YWA73PuVA14tIpUOzUndAGYPgmlQEF9cxZ4=;
        b=NSWYY/wJt7zZ5vob21TZ21S7vm3OiHKlOBy3pvlVaNjLRPOraBp+lhfqoBxB5SrkYF
         sXrNQp8kbJ6sop1GxmxuR6VxokD2Kaex3vmvX9Ra9R/BfrGKdhdAlMyDoQjYRpZQN5Ew
         gFlOw1cBUKqUEgp2O4hqturzzsL7KS6pKsle3TfNP+hgeu2aLKPF/oJZdKGvwUi9HFPH
         xS+3u7LvM3FkMA7buBF6W8bLVCoSflk6bnBdaWMXfAHOub/KDb1+jw6DTKcwlPpCIt+m
         UmmDzPCYr4lMLDrG4sdL16vh/U70fcK29nnPPkn0o6GeIiUVF/BkmA3i3isV5CI9iw7y
         3tdA==
X-Received: by 10.67.30.168 with SMTP id kf8mr96240724pad.106.1448934595576;
        Mon, 30 Nov 2015 17:49:55 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id vq2sm10752945pab.42.2015.11.30.17.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2015 17:49:54 -0800 (PST)
Message-ID: <565CFC7C.101@gmail.com>
Date:   Mon, 30 Nov 2015 17:48:44 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/28] net: pch_gbe: clear interrupt FIFO during probe
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com> <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 30/11/15 08:21, Paul Burton wrote:
> xilinx_pcie_init_port clears the pending interrupts in the interrupt
> decode register, but does not clear the interrupt FIFO. This would lead
> to spurious interrupts if any were present in the FIFO at probe time.
> Clear the interrupt FIFO prior to the interrupt decode register in order
> to start with a clean slate as expected.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Seems like the subject should be "PCI: xilinx: ..." to be consistent
with the changes you are making to this driver earlier in the series?
-- 
Florian
