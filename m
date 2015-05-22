Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:05:59 +0200 (CEST)
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36382 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006627AbbEVRF5D0DFN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:05:57 +0200
Received: by qkx62 with SMTP id 62so16392589qkx.3
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cfhnCIjvnEUAae+mW4TomXAITPUgTeppNA9K1oi6MjE=;
        b=pnN/ikpqwZ2wfF1uoybgzcuoaqFpr+U8GGqkWDSISVlmGOP5wHnzMheMHp15ujmK9Z
         INbU5pfXf5jnhPRkrLwbe0/twt+2MnUZQTuNvyGRG9TRDmV7lwKc87KjVb1AYqe7dk6/
         J9chPcMc24l6zZl1Ke0cDyoFkKMVmWq1YnYGYRyeNe1fKOMq7SmsCEiX9jupaLP46Jqf
         7PE9MbMwemhEFwVS88G9hCvZiBExXDxj/GSbbfH7zF9fIGP1C92iClVhv2PnpXRZ3aPW
         l2m8o6zSHBIp7kxfbcbXHBsvxP3Z3RtKpO39L+5ZfLY8VW8eeGx7zlvBp4hvTt4gVdkm
         QKgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cfhnCIjvnEUAae+mW4TomXAITPUgTeppNA9K1oi6MjE=;
        b=Wmc4EoWcsxhjagNHv12O8dnXHIZ4UPlQJKqaY2dlaLFRWbwbKOMMDPks+lhhufkDVS
         VuSc6vrG80cukUDeQRf05BgsEs8Ori+Dz9QA+9n6xOLC26eiE+HFu/szql5QZ6aWRiJi
         z4TlucMJ4bgo+YG9tKYcSdT71quI6TA5als0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cfhnCIjvnEUAae+mW4TomXAITPUgTeppNA9K1oi6MjE=;
        b=hltpw+MOZcgWm9rfr7bEPAZAbDX+C0VpwRkIMx5MmfekT94Vn8qIELPMNk90GwT2RW
         2KdPFGqeIGXtPQt96xY2ZdEZkj04x2Zz6bRVBssXd9kK13xs/HCYA2UgX+WPhwwPy1zO
         pFwmTrkwrnVrd5gjuWXQuJOgDAXJfz/EFVbad/QcozQk2H+0kPzbuQCckgeyBxdFeU9n
         XDoDXClb+YFQTGzlNcLTht1G9HOYfyWYAJH32482H6wJjfXyqLDOWR5UrAW4ujNcwhT7
         xJTe510CeIQLW5OENwFWL6nRe6GiMG7VUYhir//OTnQuCFyXaHs4VxxnjFYtJLycSkGP
         Pk+w==
X-Gm-Message-State: ALoCoQlsZrRY7F7TbMO140gli/Ew5w/61CdCbMY1WbVf2hb8iz9YIGRqh4RL0K+poWHYTIdEzOTF
MIME-Version: 1.0
X-Received: by 10.55.56.8 with SMTP id f8mr20040513qka.97.1432314353976; Fri,
 22 May 2015 10:05:53 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:05:53 -0700 (PDT)
In-Reply-To: <1432252663-31318-5-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-5-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:05:53 -0700
X-Google-Sender-Auth: 92F6WFvfASjufbsIEshfxTiPWuo
Message-ID: <CAL1qeaGdpxM8aDFmF+kT7GqTxoRFm6060cwwNn-dVov59bJkYg@mail.gmail.com>
Subject: Re: [PATCH 4/9] clk: pistachio: Extend DIV_F to pass clk_flags as well
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> As preparation work to support MIPS PLL rate change propagation, this
> commit extends the DIV_F macro to pass clk_flags in addition to div_flags.
>
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
