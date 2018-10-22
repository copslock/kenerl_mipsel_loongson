Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2018 00:55:37 +0200 (CEST)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:44239
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994615AbeJVWzeIw-CU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2018 00:55:34 +0200
Received: by mail-pf1-x442.google.com with SMTP id r9-v6so20632583pff.11
        for <linux-mips@linux-mips.org>; Mon, 22 Oct 2018 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=r7yZLn68sbOk7hs4CYqLx+hlOfURlzn+vBrcgdejPPM=;
        b=BRZp7GNq9Je8VCEaI+LLNRS9W8sONE95eEq1SabOCzN8yS7zATnhfVEL3MidQ8qa/1
         wXH9ctlhV325nww+A5gulHmF+ZSujfGIaVu1PCsOeX7gLh3kIgf2JUl/bUBfBvYw1V01
         /QjbJOlC1ntJn/AZLfTNFK3ohA6S1dCE9U6VAtbJNV8TYjAmNr4bRgnAFhUZh4YKXbMf
         a9fQE5j3oO1sa9O0gTIxce9loXbhL3KOz4iv4YR51lsVQqJQSrKvCE5gkCz+ZAXeJVx1
         Bv+xe/9rgZsqn6ApsK9dk2IGCH1FtEqSK86RwbTrVSh8ToDA7qAFG3jv5wkJIHUqfLdK
         tZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=r7yZLn68sbOk7hs4CYqLx+hlOfURlzn+vBrcgdejPPM=;
        b=IfIUhAJbnit52LMyPy3JHAevaR3LZHRis4C2ZcPWFhwflMWYhdKQW5CO5gHQoLOipQ
         BYsaZUI+LcKTYECe72yGtclD+qN0dhyCeWkgN8IqBCchdcKIdXyhhX7Ud7pdiBALkQxk
         51v+bTn3nXfMBt9YIJkOEnJV7t31uJCp4g25NdWoU+znjKiDSPd37Hw9wiw7cSIlQU21
         S0wXf0mGU+tQAvnP8UqUAmBO2P5fUkaMVfXyzPoo2QYUeIRq0rEcp4SsPbbMCM8Lf3dx
         RFdAQ1pP9aZHHolJ9vxg1bEUgTEskVxv0Qu/icqxToBhC6SIa4XeOsFOQyYy7rS4NN2I
         Ic8g==
X-Gm-Message-State: ABuFfoikJmniSI3g1ASggzJ4VP1lcKNMt0MhziYpHG9LpKE9/x3OzD3u
        jYbSoFkJZASqmA8AclrfA0fttg==
X-Google-Smtp-Source: ACcGV62PJPL2/X41/eubx7QEKi4M5IAsvkC1vY13646Bwl56nJ/imu7HXKrlZs7oCIAi84TX7Ijbvw==
X-Received: by 2002:aa7:88c2:: with SMTP id p2-v6mr39811945pfo.32.1540248927208;
        Mon, 22 Oct 2018 15:55:27 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s80-v6sm43083294pfa.114.2018.10.22.15.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:55:26 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:55:26 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Oct 2018 15:48:42 PDT (-0700)
Subject:     Re: [PATCH v2] OF: Handle CMDLINE when /chosen node is not present
In-Reply-To: <20181022224213.GA25145@bogus>
CC:     mick@ics.forth.gr, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh@kernel.org, linux-mips@linux-mips.org
Message-ID: <mhng-08dbc241-46e4-411b-ba13-32435abde7ad@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Mon, 22 Oct 2018 15:42:13 PDT (-0700), robh@kernel.org wrote:
> On Mon, Oct 15, 2018 at 05:20:10PM +0300, Nick Kossifidis wrote:
>> The /chosen node is optional so we should handle CMDLINE regardless
>> the presence of /chosen/bootargs. Move handling of CMDLINE in
>> early_init_dt_scan() instead.
>
> I looked at this a while back. I'm not sure this behavior can be changed
> without breaking some MIPS platforms that could be relying on the
> current behavior. But trying to make sense of the MIPS code is a
> challenge and they have some other issues in this area.
>
> Can't this be fixed by making /chosen manditory? I'd expect ultimately
> you are always going to need it.
>
> I'd rather not resort to making this per arch. There's also some effort
> to consolidate cmd line handling[1].

I'd rather make /chosen mandatory on RISC-V than to have per-arch handling, as 
like you've said there's already too much duplication.  That said, it does seem 
like a bug to me because the behavior seems somewhat arbitrary -- an empty 
/chosen node causing the built-in command-line argument handling to go off the 
rails just smells so buggy.

If that's the case, could we at least have something like 
"CONFIG_OF_CHOSEN_IS_MANDATORY" that provides a warning when there is no 
/chosen node and is set on architecture where the spec mandates /chosen?

I've added linux-mips to see if anyone has any ideas.
