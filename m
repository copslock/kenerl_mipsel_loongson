Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2012 15:06:48 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51968 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903718Ab2H1NGn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2012 15:06:43 +0200
Received: by obbta17 with SMTP id ta17so10970568obb.36
        for <multiple recipients>; Tue, 28 Aug 2012 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aWeRT5cAReuXjvII/hSl7uLrglJ6oCLi7OdJlmUNSG8=;
        b=G8nboh4ILOy9CkFG+YtBEJIYOhe+d2DhaLaURZKeby/6USYwRN7D3o8vprJeMEAd/j
         ZwXcdRi2zGfze5sevVFzKBhwPrU0h2SKa27M12MC3v63ZcEJ94L1V8Hdil+La+V7VFtX
         vNL4QwciCsP3gTllEx0VYmiNwIg9P5CnQvpFFaCunv04+s/oc4gITb3G0DlR+vgvXIkR
         skWFgM++nhDhVZtXpLMiMomtPyPv/nlo3DJzlYd4wWh8ULGIiopUEM5UxHAIGAnceU6B
         Dqr3p0s56t++0NC0hr0UzHTdB8CckANm8Z7XBJXYbE7/q3/+x3+67aqWHs7v/HEmqjaP
         50qg==
Received: by 10.60.2.42 with SMTP id 10mr12853611oer.9.1346159195125; Tue, 28
 Aug 2012 06:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.3.15 with HTTP; Tue, 28 Aug 2012 06:06:13 -0700 (PDT)
In-Reply-To: <a403b82eaffa0faf3c17058c91f047e9@localhost>
References: <a403b82eaffa0faf3c17058c91f047e9@localhost>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 28 Aug 2012 15:06:13 +0200
Message-ID: <CAOiHx=m6eJS0YNGWDLcYUaZ-cXhDa=BCkaBVY3Q0+GxwfdcTQA@mail.gmail.com>
Subject: Re: [PATCH V3 7/7] MIPS: BCM63XX: Create platform_device for USBD
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, ffainelli@freebox.fr, mbizon@freebox.fr,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 14 July 2012 21:01, Kevin Cernekee <cernekee@gmail.com> wrote:
> ...

I have no further objections and it looks good to me, so

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

(for the whole series).

Jonas
