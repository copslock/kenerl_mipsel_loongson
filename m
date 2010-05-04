Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:55:03 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491822Ab0EDJzA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:00 +0200
Received: by qyk30 with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.181.142 with SMTP id by14mr2808265qcb.18.1272966891678; 
        Tue, 04 May 2010 02:54:51 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:54:51 -0700 (PDT)
Date:   Tue, 4 May 2010 17:54:51 +0800
Message-ID: <z2l180e2c241005040254y895e5456sf37194c97f3f739f@mail.gmail.com>
Subject: [PATCH 0/12] add basic gdium support
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Gdium is a netbook based on loongson2f CPU and sm502 SOC. It does NOT
have a south bridge. The sm502 SOC is used for LCD controller and
audio output. This series of patches are adding gdium support to
ralf's linux-mips repository.
