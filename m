Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:34:39 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:44193 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFKeg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 12:34:36 +0200
Received: by qyk32 with SMTP id 32so823744qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F1SZ9vOBp2i6Ti1j0BWioJ82cSvLzvI4L4TDhm8pZV0=;
        b=gjzuXNfx8GbueyzN6aL0W/YLY9ZD/ogjAv49YIhu8V8RtXc9c1NI5zbqLEh1IolSRP
         EAJ8Vi6XyjTOGFNdzQRbV+vuJhnavHin3lxxQ+pnNpDpj3XVg4ZWDhXdQhfmsjf6B50D
         mVVYdn13dazGripGIyKf2ALorsYkh+EEo1X/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nuGt7HXR11mlL3qZfeO/OVVunV0pWHvWljnfOmOUSPFXfMUVdPqW84xsNAOE1MF0ND
         RTHVqeundCrnlpMlABpOAVgjLKVR3s/30On5Cj2W7/cmVnj9ArEZ8YDNI3k4HLLLko6q
         4SS55YPwN+aYSs+8pn9oSRQ5cljChhS2nNe1c=
MIME-Version: 1.0
Received: by 10.229.118.69 with SMTP id u5mr3377503qcq.122.1307356470630; Mon,
 06 Jun 2011 03:34:30 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 03:34:30 -0700 (PDT)
In-Reply-To: <1307311658-15853-7-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-7-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 12:34:30 +0200
Message-ID: <BANLkTim74Km0T3XRo+W8jCrb2n-dv3XxNg@mail.gmail.com>
Subject: Re: [RFC][PATCH 06/10] bcma: get CPU clock
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4085

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> +u32 bcma_cpu_clock(struct bcma_drv_mips *mcore)
> +{
> +       struct bcma_bus *bus = mcore->core->bus;
> +
> +       if (bus->drv_cc.capabilities & BCMA_CC_CAP_PMU)
> +               return bcma_pmu_get_clockcpu(&bus->drv_cc);
> +
> +       pr_err("No PMU available, need this to get the cpu clock\n");
> +       return 0;
> +}
> +EXPORT_SYMBOL(bcma_cpu_clock);

Are you really going to use this in some separated driver? If you're,
I heard that exporting symbol should go in pair with patch enabling
usage of such a symbol.

-- 
Rafał
