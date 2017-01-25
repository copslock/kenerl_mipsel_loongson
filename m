Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 05:35:40 +0100 (CET)
Received: from mail-vk0-x234.google.com ([IPv6:2607:f8b0:400c:c05::234]:32775
        "EHLO mail-vk0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdAYEfdAZRcZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 05:35:33 +0100
Received: by mail-vk0-x234.google.com with SMTP id k127so126484262vke.0;
        Tue, 24 Jan 2017 20:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=V1PwIoVVzhzp2M1mTtp8iTE3OwJ10SPYtcpIRgjwTag=;
        b=fVXqba17GClhLAUyiGEf/f2qEc6L6uFZ8flfdzLXiMpM0+a+CUxz4UCs5c/Cqr+8jv
         RNAHiH18h1TuLBPnpcjdoRBPyQSND8Mz9YRPfctgvSsXIc2yIv97mBUrQ2FZaGAJ+KGv
         ecMXfW7dw1QV+JwFgbjKbyFQKCaOe/BT5slo2dI+qlz9Nddw/lbE8P/mG60ni5eRuRVG
         u9e9M60OWscb0wc5y82EGCvf9BCdi5bAYwlIh66JYSZ+tH7ObNUxc7YIF6JhwT2kjYV1
         6hRQRnBI3rpReN+qYCfQN9VsQ7qI3gWzsnKMQ90c3hLDMbDTMGI9y0IrCApVpKh0zrY6
         z49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=V1PwIoVVzhzp2M1mTtp8iTE3OwJ10SPYtcpIRgjwTag=;
        b=eCtlB/Vdqz8w1vK91ZWDKz645yaCrU5ZBFdOS1Ym8kv2PhdIcRKRsQmD3Ybpv0CGjZ
         +EHageoMMynzQmsW/RaUetNRwgTE8pPtcpot8vaYsJ9+uV0q0i81dImn822mgZYoOCeR
         pkLWoFxSc7cL3RprGlJJYe0D1wOEYVF7LLoi1NQn/YnAM0Ee7DMHoubydT6bHONvLNlO
         UliI/1URemR2ZuiwBBNFW1e1yJJhEPnO+E+QaGp0+0DxWidif94H0as/p6JcWi3b39PR
         eboTE2ZbHw+FwBxZokj0LzdEhRwNr04euU+Lj6d1MZoogaIFFTUJ81u5eCvhlH97Abue
         P5Jg==
X-Gm-Message-State: AIkVDXIlM3/wqh9z8ZUj/L5pojLHFxiU7q/4YkD8lk6Bmin1VAGbQCQvtqcYnOtR+pwo/IuLmpbHquhMcOCyVg==
X-Received: by 10.31.2.2 with SMTP id 2mr14511885vkc.33.1485318922044; Tue, 24
 Jan 2017 20:35:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.31.140.138 with HTTP; Tue, 24 Jan 2017 20:35:21 -0800 (PST)
From:   Mark Zhang <bomb.zhang@gmail.com>
Date:   Wed, 25 Jan 2017 12:35:21 +0800
Message-ID: <CAEbrdOCo9DeOa=rXYBxCEERNu_Cq=7N+5dDOwLwuZy87D3M6bA@mail.gmail.com>
Subject: [Bug fix]mips 64bits checksum error -- csum_tcpudp_nofold
To:     ralf@linux-mips.org, davem@davemloft.net, aduyck@mirantis.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a113dd902ba80a00546e3c270
Return-Path: <bomb.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bomb.zhang@gmail.com
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

--001a113dd902ba80a00546e3c270
Content-Type: text/plain; charset=UTF-8

If the input parameters as saddr = 0xc0a8fd60,daddr = 0xc0a8fda1,len =
80, proto = 17, sum =0x7eae049d.
The correct result should be 1, but original function return 0.

Attached the correction patch.

--001a113dd902ba80a00546e3c270
Content-Type: application/octet-stream; 
	name="0001-Fixed-the-mips-64bits-checksum-error-csum_tcpudp_nof.patch"
Content-Disposition: attachment; 
	filename="0001-Fixed-the-mips-64bits-checksum-error-csum_tcpudp_nof.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iycgj5in0

RnJvbSA1MmUyNjVmN2ZlMGFjZjlhNmU5YzQzNDZlMWZlNmZhOTk0YWEwMGI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBxemhhbmcgPHFpbi4yLnpoYW5nQG5zbi5jb20+CkRhdGU6IFdl
ZCwgMjUgSmFuIDIwMTcgMTI6MjU6MjUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBGaXhlZCB0aGUg
bWlwcyA2NGJpdHMgY2hlY2tzdW0gZXJyb3IgLS0gY3N1bV90Y3B1ZHBfbm9mb2xkCgotLS0KIGFy
Y2gvbWlwcy9pbmNsdWRlL2FzbS9jaGVja3N1bS5oIHwgICAgNCArKysrCiAxIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21p
cHMvaW5jbHVkZS9hc20vY2hlY2tzdW0uaCBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jaGVja3N1
bS5oCmluZGV4IDc3NDlkYWYuLjBlMzUxYzUgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9pbmNsdWRl
L2FzbS9jaGVja3N1bS5oCisrKyBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9jaGVja3N1bS5oCkBA
IC0xODQsNiArMTg0LDEwIEBAIHN0YXRpYyBpbmxpbmUgX193c3VtIGNzdW1fdGNwdWRwX25vZm9s
ZChfX2JlMzIgc2FkZHIsIF9fYmUzMiBkYWRkciwKIAkiCWRhZGR1CSUwLCAlMgkJXG4iCiAJIglk
YWRkdQklMCwgJTMJCVxuIgogCSIJZGFkZHUJJTAsICU0CQlcbiIKKwkiCWRzcmwzMiAgJDEsICUw
LCAwCVxuIgorCSIJZHNsbDMyCSUwLCAlMCwgMAlcbiIKKwkiCWRzcmwzMgklMCwgJTAsIDAJXG4i
CisJIglkYWRkdSAgICUwLCAkMQkJXG4iCiAJIglkc2xsMzIJJDEsICUwLCAwCVxuIgogCSIJZGFk
ZHUJJTAsICQxCQlcbiIKIAkiCWRzcmEzMgklMCwgJTAsIDAJXG4iCi0tIAoxLjcuMQoK
--001a113dd902ba80a00546e3c270--
