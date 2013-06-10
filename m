Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 21:34:09 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61493 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835108Ab3FJTeEKxg0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 21:34:04 +0200
Received: by mail-ie0-f169.google.com with SMTP id 10so3758802ied.14
        for <multiple recipients>; Mon, 10 Jun 2013 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=24DaF1ufkE/kq+O4+ckyn2P7UymXx5iWB8wTVQM52E8=;
        b=tZpRAY3SEaUpc8Lkc+uBzkqgvuNrfTSCyJ7PJUlqzpzisfbPxLHQD4H8xcPqbvxW69
         ds04F5uel96MfpcItgpu4uqQdQvfIXOqYvtUFbTxv84tDIL1mOpNnNXUiSwYoRW4Z44g
         YAqHFhWJ+gWbRzpaTkndOwY/os/EXM10I0B3O3wM07RaS9DRXYdZ8ejzFBKt1tH/xQci
         miekDeV3ui40qlzZTAYlLwh+ph/O+hlMMAdTC6g70ejvQvyZk3pS++bnhojSQJeZG/F5
         do3iYNP7GlH2SsBdwUQXJYz73sOMgqQP8aZH19JjV3zAPrwcf7Kw8u8OVgOLNWV6227j
         TCJQ==
X-Received: by 10.50.152.74 with SMTP id uw10mr4803814igb.25.1370892837240;
        Mon, 10 Jun 2013 12:33:57 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ji5sm10026537igb.0.2013.06.10.12.33.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 12:33:56 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5AJXrbF021711;
        Mon, 10 Jun 2013 12:33:54 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5AJXqQZ021710;
        Mon, 10 Jun 2013 12:33:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] kvm/mips: ABI fix for 3.10
Date:   Mon, 10 Jun 2013 12:33:46 -0700
Message-Id: <1370892828-21676-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

As requested by Gleb Natapov, we need to define and use KVM_REG_MIPS
when using the GET_ONE_REG/SET_ONE_REG ioctl.  Since this is part of
the MIPS kvm support that is new in 3.10, it should be merged before a
bad ABI leaks out into an 'official' kernel release.

David Daney (2):
  kvm: Add definition of KVM_REG_MIPS
  mips/kvm: Use KVM_REG_MIPS and proper size indicators for *_ONE_REG

 arch/mips/include/uapi/asm/kvm.h | 81 +++++++++++++++++++--------------------
 arch/mips/kvm/kvm_mips.c         | 83 ++++++++++++++++++++++++++--------------
 include/uapi/linux/kvm.h         |  1 +
 3 files changed, 94 insertions(+), 71 deletions(-)

-- 
1.7.11.7
