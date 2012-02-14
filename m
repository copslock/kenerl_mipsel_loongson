Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2012 23:50:19 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:65036 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903656Ab2BNWuM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2012 23:50:12 +0100
Received: by pbcun1 with SMTP id un1so1015281pbc.36
        for <linux-mips@linux-mips.org>; Tue, 14 Feb 2012 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=yOhserrUfvkY3ZIJV3xIijVCgGVNyG2k9fouDdZjnZU=;
        b=wXjRMQrcRlvP18w5yv/Nnie/YSIPcaUazUGD35WW280QmzLqWaH9MwmCL9E+qhzxoG
         kfCVhuudaBpOtVIehr2zKS3uduYgdhirqQSx96NH6AnfUr3q7dk+SUm5l4Lz3ZHjU2kE
         Gu31lQOFEzY5JBWHt2ImGdox896QzAd5VodD8=
MIME-Version: 1.0
Received: by 10.68.229.33 with SMTP id sn1mr62871765pbc.60.1329259805433;
        Tue, 14 Feb 2012 14:50:05 -0800 (PST)
Received: by 10.68.229.33 with SMTP id sn1mr62871692pbc.60.1329259805260;
        Tue, 14 Feb 2012 14:50:05 -0800 (PST)
Received: from tippy.mtv.corp.google.com (tippy.mtv.corp.google.com [172.18.96.130])
        by mx.google.com with ESMTPS id y9sm6426972pbi.3.2012.02.14.14.50.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:50:04 -0800 (PST)
From:   Venkatesh Pallipadi <venki@google.com>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Tony Luck <tony.luck@gmail.com>,
        "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        KOSAKI Motohiro <kosaki.motohiro@gmail.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Travis <travis@sgi.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/3] Cleanup raw handling of online/possible map
Date:   Tue, 14 Feb 2012 14:49:41 -0800
Message-Id: <1329259784-20592-1-git-send-email-venki@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <87wr7pbwbz.fsf@rustcorp.com.au>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
X-Gm-Message-State: ALoCoQml0hcSZ/cyBnHtJW8mrgvObgDBbcWx+nvbV6v53pqA69kOfqW017ZFwl+4VWleF+5KhOSz5rBBDuGsgMEEynNPtetnzYyJcAwegt2Ue7/AUrKxLPyd7Lq7FuaPtpSQ6VCBA9X19FUjcaahtl6s819YeGdnnu+k8ZaVB539od8GIDhHZXc=
X-archive-position: 32425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venki@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

> Yes, and the other architectures.

Here are the patches for other instances I see in plain git grep.

I have been brave (foolish) enough to send this without any testing. So,
this comes with 'use it at your own risk' tag :-).

Thanks,
Venki
