Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Feb 2016 18:36:05 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35441 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008000AbcB1RgDDEr1G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Feb 2016 18:36:03 +0100
Received: by mail-lb0-f179.google.com with SMTP id bc4so68781954lbc.2
        for <linux-mips@linux-mips.org>; Sun, 28 Feb 2016 09:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EHD1UDqYSJayycE5rZQcHOrAAAPGNvq7OW6v5im5DQQ=;
        b=AG28ASJY4hZcIV1qXjj7YLrOJAECQdlpdXu6VYZ4h3k/6ngOPKd/NqhiXr9Gq3kQdJ
         dg8ARlDQLhg7krSeD3hjpf6P/lFv+iYjesZPuanYkJRN9IYPQASxVqYXdWlnnXakRvF5
         YfWktqEGO7yF9loUyf602f2VOSaAyGRXBxemtMrNKPoDNQ4NWQ2/o/lTjhFR9Efr9sAk
         A3qwNTJDxfTbAIc/Vo3dP+/2CivkfyDLVqMtTDu+cw51gEopsL4cb8PEHtyXjdpOysTO
         31Dy2Osa4Cqe6Ut/lvmK3MaCOo/YQVHxfQxWPWu0cDFKJ/08j5nkYz7ItlcU7h+ZTul+
         F+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=EHD1UDqYSJayycE5rZQcHOrAAAPGNvq7OW6v5im5DQQ=;
        b=BXuO0I6A5BCRMq4uxqO4vN3lqRo8w27A1PD+Kg5cfKKzkUVD64xq6jKVR+nFEkd8zK
         81JKabahuhiQjCDZq60C5M4Gc4Vz83FXHRc3N/UufHy8+kzVS8edTDtIDbCURcFiCrT5
         0trY9OBWB6HvqvXtlw8gRcuzcjEWfdDFIYNW53E/g2YjM0r0MgvzzIcgLUjVXGZL7FrI
         VbnY4FDfx6JD8VoBUtigj3RBCX5/UIW8XS4iVvW8VivnrZ1Q+AHI9DELc2niPhlM/vKB
         TgyUV/jdqVr2aef7sItl4j5C2C/VHw8/RF+mg5yuiZ38KcCPV3V/wRCS7hLwP4BUsO7m
         FaAw==
X-Gm-Message-State: AD7BkJLX5cZoLsW07UGi/knI7Wj/w+5lOjoBmvIQDdCoTySh/asNv5chZOuFm7gzTvDB1A==
X-Received: by 10.112.132.5 with SMTP id oq5mr3979165lbb.16.1456680957670;
        Sun, 28 Feb 2016 09:35:57 -0800 (PST)
Received: from wasted.cogentembedded.com ([195.16.111.30])
        by smtp.gmail.com with ESMTPSA id s75sm3277720lfs.21.2016.02.28.09.35.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Feb 2016 09:35:56 -0800 (PST)
Subject: Re: [PATCH for-4,5] mips/kvm: fix ioctl error handling
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1456673711-24132-1-git-send-email-mst@redhat.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56D32FFA.1000907@cogentembedded.com>
Date:   Sun, 28 Feb 2016 20:35:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1456673711-24132-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52356
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

On 02/28/2016 06:35 PM, Michael S. Tsirkin wrote:

> Calling return copy_to_user(...) or return copy_from_user in an ioctl

    Calling return? Perhaps "returning the result of"?

> will not do the right thing if there's a pagefault:
> copy_to_user/copy_from_user return the number of bytes not copied in
> this case.
>
> Fix up kvm on mips to do
> 	return copy_to_user(...)) ?  -EFAULT : 0;
> and
> 	return copy_from_user(...)) ?  -EFAULT : 0;
>
> everywhere.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[...]

MBR, Sergei
