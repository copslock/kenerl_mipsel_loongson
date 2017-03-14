Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 23:50:05 +0100 (CET)
Received: from mail-pf0-x22a.google.com ([IPv6:2607:f8b0:400e:c00::22a]:34392
        "EHLO mail-pf0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdCNWt5wraVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 23:49:57 +0100
Received: by mail-pf0-x22a.google.com with SMTP id v190so230177pfb.1;
        Tue, 14 Mar 2017 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WE2QspQon49hcWP8lCrRpM8WFGQN0nutE2gjD3uQex8=;
        b=FcoNO1XkXmDQHxrSd4/kv5GGn1JngbcSxsHbCDcWJudAb1/QlrSmA+9+wrOd2DlOOF
         zi/uddZ5x+9xHPtgd5yNbqRtdoNfTlQd4MrMQncBuG9MSxTVyh/juW3HaQwxTBQptJvJ
         spqMf+SLh5wg+sgOyxNokvxwWUfY21no4sAI8AQmCwXzvXJgdceaMgSE8NM9ZLtWuKVU
         k3YfvOMtbifoLw6BQl46YUmtNCAbTRy1yXe/gzBJVFd+KfbSXbcvpsC8q+wpWbsXRBiw
         3Cx3Ju7c3r9Io9N3tPll62ycMFIhq/JOlgPYMkP3vMVhVUC8RTOcZt+RiLOHswYdDY7Q
         L6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WE2QspQon49hcWP8lCrRpM8WFGQN0nutE2gjD3uQex8=;
        b=hCj+5AzEt9Z0yqFdfAhbRIJygkRAnF9aryUrWEUptZs+ZEsZRYm+927HYk9XmuJdpX
         8ZkfsXobDABkeF5I94rmzlGX3GRRK9vA4M2XR0ZKe6EOylMyu/ZDPaj4IKWzUza7/blk
         shqFWsVqwo5+052Fwd2gV1pF8UtA4x3zzEU5hJCEoj9NcTtOXAy/aAkGUmEK4f1vde3+
         zTeQzcY3mg/icNdZI32C1Cbv0rk13/QGV9ZOEmpe4vMqgLaUR8VOHq5tql+6Vr+DKxet
         0lUAJm6t5ymPBjk1AI9tv1G5PotJLvUPFDhqYXDKupwPrKVnxuabqU3lc9gbK8B45jhU
         XEkw==
X-Gm-Message-State: AFeK/H3EQ+4KW6X38odV9oTU2276tCZftpIlVbmCVkXxA7ZuJwAjPVjtjuEFTPbD0v3m+A==
X-Received: by 10.99.140.69 with SMTP id q5mr66381pgn.179.1489531791992;
        Tue, 14 Mar 2017 15:49:51 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:180::d40d])
        by smtp.gmail.com with ESMTPSA id 80sm42215pfy.67.2017.03.14.15.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 15:49:50 -0700 (PDT)
Date:   Tue, 14 Mar 2017 15:49:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
Message-ID: <20170314224946.GA11983@ast-mbp.thefacebook.com>
References: <20170314212144.29988-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314212144.29988-1-david.daney@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Tue, Mar 14, 2017 at 02:21:39PM -0700, David Daney wrote:
> Changes from v1:
> 
>   - Use unsigned access for SKF_AD_HATYPE
> 
>   - Added three more patches for other problems found.
> 
> 
> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
> identified some failures and unimplemented features.
> 
> With this patch set we get:
> 
>      test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
> 
> Both big and little endian tested.
> 
> We still lack eBPF support, but this is better than nothing.
> 
> David Daney (5):
>   MIPS: uasm:  Add support for LHU.
>   MIPS: BPF: Add JIT support for SKF_AD_HATYPE.
>   MIPS: BPF: Use unsigned access for unsigned SKB fields.
>   MIPS: BPF: Quit clobbering callee saved registers in JIT code.
>   MIPS: BPF: Fix multiple problems in JIT skb access helpers.

Thanks. Nice set of fixes. Especially patch 4.
Did you see crashes because of it?
Acked-by: Alexei Starovoitov <ast@kernel.org>
