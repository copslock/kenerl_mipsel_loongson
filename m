Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 10:25:11 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35956 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008078AbbFDIZJHnLlX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 10:25:09 +0200
Received: by pabqy3 with SMTP id qy3so24829301pab.3
        for <linux-mips@linux-mips.org>; Thu, 04 Jun 2015 01:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=uqCsW3dg3vnZLJ4m7kOAO1Be+mefCytXK4mIX5DH7Gs=;
        b=WJx1AhfIAlOGgHBemFXrc4pCmp/+tDvkUbf1X6ZDF5kATTunGMaGw1+I75yNm7/YTN
         XxRHvs8qMGGtnOfi/4ircvDtY9AJudXRyGaWTrNn6i0Fdrdlv7zw1Hp6me6xafYsQR7R
         Wx/yzozWv8UMlhYgQO7gqOYdTRLa1qjnWHU3wTLT6DcpoeaJ6dgW/np+06P1hgKqCrbC
         mfW4I6KIL8L/MQZ/O0Kz3K9LOrn0Jcqi5TIKMUowFAspFpeghM7HQGcx/L68e56qRscA
         huDa2jEhj1Epw7UJsqUZya8Su/RTSM0j4ZdaTdv/06Qpsp3uzNy2k86nIT0HFA9n6zXN
         o2zg==
X-Gm-Message-State: ALoCoQk5M1eyxSBJNVW9NaOGYzxV+wCFwRZ/BSiKJzNa6QkLrcKy//HYmb7EaUtSy5xAG6Z03uW0
X-Received: by 10.70.91.3 with SMTP id ca3mr33252865pdb.16.1433406302177;
        Thu, 04 Jun 2015 01:25:02 -0700 (PDT)
Received: from trevor.secretlab.ca (p2208095-ipngn17401marunouchi.tokyo.ocn.ne.jp. [153.224.29.95])
        by mx.google.com with ESMTPSA id qo1sm2906839pbc.89.2015.06.04.01.24.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 01:24:59 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 8BF05C40D1F; Thu,  4 Jun 2015 17:01:31 +0900 (JST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/3] MIPS: prepare for user enabling of CONFIG_OF
To:     Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org
In-Reply-To: <20150603082410.GI9839@linux-mips.org>
References: <1433285204-4307-1-git-send-email-robh@kernel.org>
        <1433285204-4307-2-git-send-email-robh@kernel.org>
        <20150603082410.GI9839@linux-mips.org>
Date:   Thu, 04 Jun 2015 17:01:31 +0900
Message-Id: <20150604080131.8BF05C40D1F@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 3 Jun 2015 10:24:10 +0200
, Ralf Baechle <ralf@linux-mips.org>
 wrote:
> On Tue, Jun 02, 2015 at 05:46:42PM -0500, Rob Herring wrote:
> 
> > In preparation to allow users to enable DeviceTree without arch or
> > machine selecting it, we need to fix build errors on MIPS. When
> > CONFIG_OF is enabled, device_tree_init cannot be resolved. This is
> > trivially fixed by using CONFIG_USE_OF instead of CONFIG_OF for prom.h.
> 
> Want to take this through your tree?  If so,
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
>   Ralf

For the whole series:
Acked-by: Grant Likely <grant.likely@linaro.org>
