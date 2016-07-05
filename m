Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 13:17:02 +0200 (CEST)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33850 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbcGELQzL5oOm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 13:16:55 +0200
Received: by mail-lf0-f47.google.com with SMTP id h129so132550665lfh.1
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2016 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UjgporceJkz4cKdSav6DbVCM/XNdokSMRj2Z5GwcJqU=;
        b=siOKPN935bZW9U/ZNqHctQlPwXVQe6078UpJEaDfjv3oMLztx+YWDXwGuumB8YU86n
         TSir66ovswc4XZPMRVfyC/GdETnAq5hEWSy6e9gZ3KNMev1KJwikaHEh0CVMrcbZ27S3
         DVCzIrh3rgGSdCOgBZhtoL4TqE/eNu76NG7b++XgyePiSMhAHsGzxSmOziF/PJT1l+Kf
         FpuZapXxV91EeetjYpettOEoPgcR/JkzCI9vqElB7isFhKDb77SENXR/stVZmflx+DXv
         oDDK57kMzfgaua0thLzwQB8JbqaU6Bky5cHYzS5RUUUkRQ9OrDNglZgKwuqiGiTIU5n0
         +Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UjgporceJkz4cKdSav6DbVCM/XNdokSMRj2Z5GwcJqU=;
        b=PK0x6eK3fT8Czgmm+26BCnPVG/ryoOwtdI4Zp3x0uHn4sR6l3HVVKZFL4sPZLQQ4Va
         4h+YFL1qilO+LVLAVYevD00zuWqoSvf0OWYrUJ2tiR/aMpB/wQdtqmKb8Owuva0WB+s8
         EAyhWHtxds+vaM0cOc8sK7ZWkwcBkslJx2kYXQflN0eP0SNtcTYtSUquhlozqQJht0Ex
         u6AYMjYTY3JndJfLbDa8NAw4ubLQpnS5kEzh5o138AIfSIfwLQL9YBKW79272DEytzHH
         HvSG4/Ix8oEvIHxl/D5sQLZa1x8mHGF2fgiE9xyFgDW2HkWTVc/A/54Juff5yWNdtRAG
         K0UA==
X-Gm-Message-State: ALyK8tLy7HfNs6cSR6gUU9HGdjhAPfAA8k0T++rBVJkT6SsFBLYsZrmVpyiepc+jTjo3pg==
X-Received: by 10.25.83.80 with SMTP id h77mr4507432lfb.83.1467717409752;
        Tue, 05 Jul 2016 04:16:49 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.90])
        by smtp.gmail.com with ESMTPSA id e195sm168036lfg.13.2016.07.05.04.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 04:16:49 -0700 (PDT)
Subject: Re: [PATCH 8/9] MIPS: KVM: Decode RDHWR more strictly
To:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
 <1467657315-19975-9-git-send-email-james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <24b4b1b6-2a58-63f8-f2c2-78ecc6eceb4e@cogentembedded.com>
Date:   Tue, 5 Jul 2016 14:16:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1467657315-19975-9-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 7/4/2016 9:35 PM, James Hogan wrote:

> When KVM emulates the RDHWR instruction, decode the instruction more
> strictly. The rs field (bits 25:21) should be zero, as should bits 10:9.
> Bits 8:6 is the register select field in MIPSr6, so we aren't strict
> about those bits (no other operations should use that encoding space).
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> ---
>  arch/mips/kvm/emulate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 62e6a7b313ae..be18dfe9ecaa 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -2357,7 +2357,9 @@ enum emulation_result kvm_mips_handle_ri(u32 cause, u32 *opc,
>  	}
>
>  	if (inst.r_format.opcode == spec3_op &&
> -	    inst.r_format.func == rdhwr_op) {
> +	    inst.r_format.func == rdhwr_op &&
> +	    inst.r_format.rs == 0 &&
> +	    (inst.r_format.re >> 3) == 0) {

    Inner parens not necessary here.

[...]

MBR, Sergei
