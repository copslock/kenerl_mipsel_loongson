Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 20:27:58 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:36120
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992568AbdHJS1vzQJUN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 20:27:51 +0200
Received: by mail-oi0-x241.google.com with SMTP id b130so1364909oii.3;
        Thu, 10 Aug 2017 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=CswLx2Iq+2mMEyFhWrQ8ZIMTIrc1qdNsaDMmN/U/ANQ=;
        b=A/d05yJT9UpoVSdbdSDh4s7aIg3WLdwf/Sp4/jxP7w0aqqy6zvPx0Gw4A13jxEFm3a
         Lovcu6cq2z5ruuv0Lq+nz8ioGNednFd5ZoUKYi8yO14oqIrwpDN4NWRE5zT4KcrLKl1c
         niFNvj6KGs8hCQLDHiF/hLEoZN2x0aPlBglSGTZaEPFLEPbHq3z+QfSJyGguPKqqh1oT
         F2Je79wynDk0e4tG7z0FAiOT/+7ECZ4MHa8Hdcqjj6QcMi4MPKJFHkSWnLPJE+4xw8J+
         Czn5eueuvg+yBr8NueGILyCn6f1e+NUt++SH0GSlmZnvJMGaCO24duLx/ojbcfuhYQ6f
         tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=CswLx2Iq+2mMEyFhWrQ8ZIMTIrc1qdNsaDMmN/U/ANQ=;
        b=VGGUolFEuYVrZGUI8917y3EZ414UIDPttq1Q7xgn9C7e+9LsTiRVRvxNWlfBpkGSq0
         np44QM5hM2oiMUC9UKzu04Q/8wni88qMLO5IW3AV89O536FsIjQxhmOICEnkmH4nGQOb
         RXEbqEJbYNeR/RQWAFvtWfkebTXBittxC/8gCZPosMyOmIWsVFpWW7b5m9OKoYqo+WBG
         2bemJl+hvAXREJ9TiTo50i5I/0BqzfdRoGHv+nW5EPrW4Nz3O+ZXXGE1AXc9K6DTMs9U
         GYzTy6Ki7zbQHlWhXOxnzoJS2GennWMQm0YD8EUQrE81+R8AsDoKnblgb09M+T91Uvv8
         SukQ==
X-Gm-Message-State: AHYfb5jA2/dsbNNzT+k2WCWfScDa3gR17OK2429TXPM9cT/1n3F2CpWU
        GlQfHOLyRTawfZD3mQbYwg==
X-Received: by 10.202.62.4 with SMTP id l4mr15086665oia.109.1502389665490;
        Thu, 10 Aug 2017 11:27:45 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id s68sm7831429oie.16.2017.08.10.11.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:27:44 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 7443893;
        Thu, 10 Aug 2017 13:27:43 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id EB536300070; Thu, 10 Aug 2017 13:27:41 -0500 (CDT)
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mips: fix various issues around backtrace
Date:   Thu, 10 Aug 2017 13:27:36 -0500
Message-Id: <1502389660-8969-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

These are patches for problems I ran into while handling backtrace
issues, both inside Linux and when processing backtraces with gdb
in a kernel dump.

-corey
