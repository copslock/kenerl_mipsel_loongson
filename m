Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 01:28:04 +0200 (CEST)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:58568 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011557AbaJOX2BIJdID (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 01:28:01 +0200
Received: by mail-qg0-f41.google.com with SMTP id a108so1775029qge.14
        for <linux-mips@linux-mips.org>; Wed, 15 Oct 2014 16:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u0NS9yWlGHVNVP+LFMEpCQIj3MMm8Shs8aMnlpAgF8M=;
        b=oRfZYEUxru85/X73feZ9K8jJkS1yX8K5lwNkUI9jrnaP4OEXLVISC/9xAFXnwGEFWM
         /isgBBMhevcnVWGMK4hrL4wfWqQPeYj7ahATK5styoMe8MrNp4ynh8pCs4k9sAe8TanP
         LMMe+jf2K4ooZSeCedSgj2jUlyOHsoBM1gzA6ltmOTqkHCSFJJZV4pof3RjU/Q57W8Om
         6oWy5eyAepoG0aToL4uOiTu3R/fL9uHTDCPt0ZldRmExmtZNKRzNltf6GPnaOplEyqLI
         TmBaDHNqVS+cr91f971znedlWsTT/bPt5+16U7mKS0AjT+0rW4lzZpE8beZwT1q8nmzZ
         APYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=u0NS9yWlGHVNVP+LFMEpCQIj3MMm8Shs8aMnlpAgF8M=;
        b=bx9+7Lp3q8ImPNqXmqjGNkTpPFC7mHkctqllHtW9PRaOfqFzT0C0Mo69jq3kwx97Fl
         zQ9iZG2M4VC0EnHPRLbm0dHYNxanyTgzpMu1/PqSn4gaE+O9jk00uGR53EhKox6PszqM
         1gVimcJ5FpZyN0NLJ0daFD4jz47xXdv41HwdgeuD1t3Uz+N3SxN4eLY+ume0WMGTNbWA
         7B6p/87D6eT4Bz2lLpAIQIoaSEDESrV5aqbPSkkrqadPl+RKuvP3xrLE6iqlwkOoDpgS
         nS8EonGVIdsq5CEUvfwE6R5OBlhWTNxnqDhrgiZPrVF7RzbUTjskKIvNYWMf07PehsuB
         0ECQ==
X-Gm-Message-State: ALoCoQlYjSNdP32Z/GKuH3PWDbZTzDRcgCGJJMIjNe/xzsbZaCkVbupE0ViG/8KJYGjIizc9bu0y
X-Received: by 10.140.109.181 with SMTP id l50mr2792824qgf.80.1413415675269;
 Wed, 15 Oct 2014 16:27:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.161.79 with HTTP; Wed, 15 Oct 2014 16:27:35 -0700 (PDT)
In-Reply-To: <20141015170609.4063.10668.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170609.4063.10668.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 15 Oct 2014 17:27:35 -0600
Message-ID: <CAErSpo4ZhxFxRT9=ww8F8bKkfQe5jQTtfSvw2XfxAPvHzArKTQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] MIPS: Remove "weak" from platform_maar_init() declaration
To:     Jason Wessel <jason.wessel@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

[+cc linux-mips]

On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> arch/mips/mm/init.c provides a default platform_maar_init() definition
> explicitly marked "weak".  arch/mips/mti-malta/malta-memory.c provides its
> own definition intended to override the default, but the "weak" attribute
> on the declaration applied to this as well, so the linker chose one based
> on link order (see 10629d711ed7 ("PCI: Remove __weak annotation from
> pcibios_get_phb_of_node decl")).
>
> Remove the "weak" attribute from the declaration so we always prefer a
> non-weak definition over the weak one, independent of link order.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/maar.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
> index 6c62b0f899c0..b02891f9caaf 100644
> --- a/arch/mips/include/asm/maar.h
> +++ b/arch/mips/include/asm/maar.h
> @@ -26,7 +26,7 @@
>   *
>   * Return:     The number of MAAR pairs configured.
>   */
> -unsigned __weak platform_maar_init(unsigned num_pairs);
> +unsigned platform_maar_init(unsigned num_pairs);
>
>  /**
>   * write_maar_pair() - write to a pair of MAARs
>
