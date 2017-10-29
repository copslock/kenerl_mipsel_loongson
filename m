Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 18:34:11 +0100 (CET)
Received: from mail-yw0-x244.google.com ([IPv6:2607:f8b0:4002:c05::244]:56890
        "EHLO mail-yw0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992176AbdJ2RdlpiIBr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 18:33:41 +0100
Received: by mail-yw0-x244.google.com with SMTP id l32so9601023ywh.13;
        Sun, 29 Oct 2017 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/6NYdfMT958+EBHLFilaOgnKcJzN0fZ6iY+0rBiI58=;
        b=qw/cMxJgpnRNHKL982VpFejmv5V656jzUX+5igGSRxuj4fMOpsbLLbwdaAygIAgz+r
         pTj0p/+lnqI+SfCk45Plj7TbKa1bk6asRHQvvtuf6QRcysZWVY//DDflrUi4xpmK2AsC
         6taljWQglBrm7lYTo7G/BAg3fG2+e42Ovhci2UENxbP36q17WD0L0ATSCA+/6orRDvDM
         Qj3iCd/FUzBV2WuAHI8eDd3P+A5xERY7yhQr5e+cCVAM21JmREi3qr5L58R9+4mOmMQ2
         YNp623lRoYMp+f7A84GVvHGQRnzYmzWc4i6zcxjnJvSuNjS1f/w4UnPT9ulYNdpHd9X/
         srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/6NYdfMT958+EBHLFilaOgnKcJzN0fZ6iY+0rBiI58=;
        b=WSiuPyuzOK3WXKlRqTyIU2qVlmdrHYG3Sd5r0mNry8AceXjHqsMiyFn5u0Pzy91UaV
         LxuCMGPLTn5qyFUP699TQUFItC5TZVkBEZ5gZgnnFK11XnAXMfQZPwiaSMN6rgomvrD+
         fieoceJl8gApCrLTOgoh1nH2Xx5KpAIyoblpGTQVaN1Yjyv+TvmyTNNUDdEp3EZJ5jxF
         5BiSBbHYcM2tT0JImuwZ1kAcx/MuqtkjtnGBUoXcGgn1tbEq1q2QvPY+fbwTM89Z93GA
         Vx9tuEvw4LUEUTs8rNDbFcV95TJXt/O06xEwTw/pbWZROZeJlb0tj34SRI3ZPX0geF7t
         zoFA==
X-Gm-Message-State: AMCzsaXIMD9jb8lau4LdnB3TTh5xssmaYIIjV+FJX1gYrPnhuWqvGEVB
        4mU+eVj+5FBAajCbiLipITw=
X-Google-Smtp-Source: ABhQp+T3QA9nzFEtlUhrsOD2u/mj3hTHbvppwjbsAIjYObc5RotUREtJA7jckgZGBkGq/dVf7eqRvw==
X-Received: by 10.37.107.76 with SMTP id o12mr651064ybm.379.1509298415891;
        Sun, 29 Oct 2017 10:33:35 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:35db:b726:7a31:93b4? ([2001:470:d:73f:35db:b726:7a31:93b4])
        by smtp.gmail.com with ESMTPSA id p193sm6254938ywp.14.2017.10.29.10.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 10:33:34 -0700 (PDT)
Subject: Re: [PATCH 2/3] MIPS: AR7: ensure that serial ports are properly set
 up
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-3-jonas.gorski@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c54dae81-5c22-1ccd-4b96-15dab6e603f2@gmail.com>
Date:   Sun, 29 Oct 2017 10:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171029152721.6770-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 10/29/2017 08:27 AM, Jonas Gorski wrote:
> From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
> never copied, resulting in a dead port.
> 
> Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> [jonas.gorski: add Fixes tag]
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
