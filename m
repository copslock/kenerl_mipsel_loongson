Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 13:44:21 +0100 (CET)
Received: from mail-ot0-x22b.google.com ([IPv6:2607:f8b0:4003:c0f::22b]:32876
        "EHLO mail-ot0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdCOMoOrkL-n convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 13:44:14 +0100
Received: by mail-ot0-x22b.google.com with SMTP id 19so16863778oti.0;
        Wed, 15 Mar 2017 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=loDDV3IVQ6mkO+CfdItbdK5z702yjO9e2rcfOihlA0w=;
        b=bAAmR9T/ueMh0KP0SGDeUuruPOVQMBUXZAhw7sQf0LbIeny4ZP2w6Q6TA8PwsuSzm5
         1OWIFWMxoU5qj/1zR13KxJYsoX+43NA7TQ+XKgbIfcjrJh+eAEkfzLZH5+5hDUCSmWL3
         lNhNMmJ601j6rhVni0y005Xw0AuYRdi0Buaao8edYCODDkdaDV/zTq/60CtG4Nom2H7N
         GzudGzNTfHPNQM4m0M6WWDXT3+PgSyseUlVVtCY7RLZxLrjNzuMn8U06QOraQ6/CVJI4
         Wjgzc/EqjQleI0nlxtXLR0Y34hCHMgYzlr2e9y61RC0DD1L2+co1MvCCN2gmfNyVZ3N4
         HbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=loDDV3IVQ6mkO+CfdItbdK5z702yjO9e2rcfOihlA0w=;
        b=PZ0vf68WAenjImosnULmb9+pTrQCOapAS8yv4rVsMRLZSlEuCl+kY62dO1xaWeSmo4
         J2WkA2lo8N2RdvAS78zhoKlE5gasMgbxKLRkBFl9mIIS2DTC34Y454cr1iX8Pu2Gozbj
         x5+5PqAG0ky1nWCU8TXjC9g5HvbmtesrrHd46yBOr9bxdif49NfL9yh7W55bo8s+0fS8
         YqljUVWX9cP8UahmEguP7yD0qQvgIQDJ3DySlTwFzTFCuSD180ehTExwYSzUVyMik5i7
         BivTGNXAFEuB3ih7Nl3nmbE7m2MnYvxblGx4fijPVp4Dl+It/PDEs/FeCSTmelq3ljI1
         flYQ==
X-Gm-Message-State: AFeK/H2yFIk0w52Gkge78zpAQ8AqxD8GPr/F0AfXGBxUls3E+dzSIwrj/vODMn93phw/0v2sXdGU13lbQUVy+A==
X-Received: by 10.202.228.17 with SMTP id b17mr1609569oih.212.1489581849086;
 Wed, 15 Mar 2017 05:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 15 Mar 2017 05:44:08 -0700 (PDT)
In-Reply-To: <20170315072213.GC26837@kroah.com>
References: <58b2dd95.18532e0a.7645f.aec1@mx.google.com> <CAK8P3a2nhoxgCT3467=+CLe9zeWqJa1oKFtcPoCut-1z5jacqw@mail.gmail.com>
 <20170315072213.GC26837@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Mar 2017 13:44:08 +0100
X-Google-Sender-Auth: kkTY6rz6KUlktPwZfR6k8COky3Y
Message-ID: <CAK8P3a3T6y=JiutqCm16eD-48Eh1itzfZCbQxwmFL=a44s7YPA@mail.gmail.com>
Subject: Re: stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28
 warnings (v4.9.13)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 28, 2017 at 02:50:03PM +0100, Arnd Bergmann wrote:
>> On Sun, Feb 26, 2017 at 2:52 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> >
>> > stable build: 203 builds: 3 failed, 200 passed, 5 errors, 28 warnings (v4.9.13)
>>
>> Only one warning that doesn't also show up in v4.10-stable
>>
>> > bcm63xx_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>> >
>> > Warnings:
>> > drivers/net/ethernet/broadcom/bcm63xx_enet.c:1130:3: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> df384d435a5c ("bcm63xx_enet: avoid uninitialized variable warning")
>
> Also added, thanks.

The build is clean now except for these warnings I'm still working on:

1 net/wireless/nl80211.c:5647:1: warning: the frame size of 2064 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 net/wireless/nl80211.c:4362:1: warning: the frame size of 2232 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 net/wireless/nl80211.c:1879:1: warning: the frame size of 5704 bytes
is larger than 2048 bytes [-Wframe-larger-than=]
1 drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344
bytes is larger than 2048 bytes [-Wframe-larger-than=]

Thanks!

      Arnd
