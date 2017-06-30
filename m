Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 20:32:43 +0200 (CEST)
Received: from mail-io0-x22f.google.com ([IPv6:2607:f8b0:4001:c06::22f]:35937
        "EHLO mail-io0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993897AbdF3ScgY0T5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 20:32:36 +0200
Received: by mail-io0-x22f.google.com with SMTP id z62so28622572ioi.3
        for <linux-mips@linux-mips.org>; Fri, 30 Jun 2017 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apm.com; s=apm;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a/MnP9kxhYOEhuj3+chvEPjjTI7cbHXWougWuINDYzc=;
        b=EfWWYkerKh40+YInHNcAHoH3Qqgr3+cBz5XLrXpuOgCG6HF2nF4VqATXhpdjuw5KF4
         f4Z9fZFP69LtVGPjOX2DKYFWRKkIUz+d4/so7k8zMo3AAdYzJeGejw0aoaODOr1qSNm1
         IWIUY0LOPzAKje3z5ekGnV4ttWQ/PGrR9yORA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a/MnP9kxhYOEhuj3+chvEPjjTI7cbHXWougWuINDYzc=;
        b=SeNmMxEKDfMOLVhmLcDcO8+8XTe6hteWHLh7QkvueoCRyUhCfCktBYZIpgqfUaJ2ed
         SnivHGe+aUgcJVHX4pikMjOVO6pWTp1YW48btAxanw9jt5XP0T5Nkpfp8NH8UmiO9PKh
         CgtSFw8Hf3VMsLB9PFRsaILoYmvD4705z2cufyd490/iZUqJjK85kWQDx+V6aqCSK6Qt
         2ms1+tPoDxsKTKpcjVuqoRpW2JKQmRJ8ewPgG4Wt5KQvIPV3p7cuU43sozL2BWNr5oUv
         yUNWioFL1fLcZ5ZdF6RsjDhul2B0sSh1bVN8EMzDDXWAIb45JZ1bRpSHSgUFCT/Ucs4v
         DqFQ==
X-Gm-Message-State: AKS2vOwXvLqucqZx3JvQzXFbnvL0IWlFsbogj0E3Fj2SYJmGMFcIVJZR
        7YpX5PAj7EoE0c0Ro1NIEypjFDWTlgQV
X-Received: by 10.107.161.199 with SMTP id k190mr22414184ioe.187.1498847550582;
 Fri, 30 Jun 2017 11:32:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.9.214 with HTTP; Fri, 30 Jun 2017 11:32:30 -0700 (PDT)
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
From:   Loc Ho <lho@apm.com>
Date:   Fri, 30 Jun 2017 11:32:30 -0700
Message-ID: <CAPw-ZTn=3kfEjs4OqKOkPY3wFi8tGmXfbv2CO14CLhycCM6hHA@mail.gmail.com>
Subject: Re: [PATCH] EDAC: Get rid of mci->mod_ver
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Mark Gross <mark.gross@intel.com>,
        Robert Richter <rric@kernel.org>,
        Tim Small <tim@buttersideup.com>,
        Ranganathan Desikan <ravi@jetztechnologies.com>,
        "Arvind R." <arvino55@gmail.com>, Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <lho@apm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lho@apm.com
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

Hi,

>
> any objections?


No objection for X-Gene EDAC.

-Loc
