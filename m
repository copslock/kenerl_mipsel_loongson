Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Aug 2010 17:07:38 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37816 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491090Ab0H2PHd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Aug 2010 17:07:33 +0200
Received: by wyb38 with SMTP id 38so4594674wyb.36
        for <multiple recipients>; Sun, 29 Aug 2010 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=J2boE9iyGxohIlycBZS6DZZe/EuIdFPJDmOBdQwF8Yg=;
        b=PL5Q90Y+EvHZHY0L+Qtj6FWx7RxKH1iICBptM0QkZSMTQ0XKKLBDdaoZrSuxZqnhhN
         DHnwa3/YmG+NxEu0Miv46HZmxJAaQFkIfByhGiYHMzbjSNr1K4AReiC5IewUh7H5bj8a
         u+RL90CWv66WEqTzccQxTfGSHSydHcwK2GI0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=WVr1XzN9NAb1VC4iTNfFxBYGGiC1eBORxIU45BmDl2IItYh6e48AKkksK0bVkQfwo/
         FFNlmY42/dO2pxx8ipPQsMIn4Qywv5UeOvjZHqcX1as2qsIixRdbxvPS7zCb0zJ8PZRj
         1kBcWl6B+arOugmr9A2xYT8MzEme8tCtt7PIA=
Received: by 10.227.12.223 with SMTP id y31mr3157034wby.193.1283094448081;
        Sun, 29 Aug 2010 08:07:28 -0700 (PDT)
Received: from lenovo.localnet (129.199.66-86.rev.gaoland.net [86.66.199.129])
        by mx.google.com with ESMTPS id b23sm5440543wbb.16.2010.08.29.08.07.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 08:07:26 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 29 Aug 2010 17:08:30 +0200
Subject: [PATCH 0/2] AR7: add support for Titan TNETV10xx SoC
MIME-Version: 1.0
X-UID:  182
X-Length: 1425
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201008291708.31485.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

These two patches add support for the Texas Instrument TNETV10xx SoC (aka 
Titan) variant. Since the chip is almost identical to ar7, only a couple of 
places had to be modified. This is 2.6.37 material. Thanks!

Florian Fainelli (2):
  AR7: initialize GPIO earlier
  AR7: add support for Titan (TNETV10xx) SoC variant
