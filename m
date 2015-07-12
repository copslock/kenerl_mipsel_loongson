Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:11:32 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33332 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010495AbbGLXLNAvLge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:13 +0200
Received: by ietj16 with SMTP id j16so51572941iet.0
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=4HCZLLmDv519u4GPcRWt/e6kmIKJhW+nOTy+dNXuL/s=;
        b=A66THID4TZpo2u+wtTmerbBSyGPUYsuDbIZVwAfYjjqtGo8FZ/+jhlxVnIJFxnHWbI
         efAeu8vaf2EBdLP8M3YdQa3Xzco22RokuBWGWlee7PBxjLxpqM9U93IvyB/RwgCa4tY7
         8szAjcaJcYHFWxIUtZ4qwh0u+L7774YvKbKdxvftPnyqiWUuugfuyTA4sFXA/P6SgftJ
         SIYqY5VPdfvSAbJYB3X7k+OVjm9Bsk7ozUw39JCka4BRGYBDNCRG4DomgPzxcA+C/nsn
         AWAv5uWNzOYHrD2dLNf7cgPXd+1R7irDhXaSGCgICLgezGcgsRL9K+qn7utMardE0qEm
         TPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=4HCZLLmDv519u4GPcRWt/e6kmIKJhW+nOTy+dNXuL/s=;
        b=gMshkG45dQDIbjYi48UxIijLAaUYlvUpj83Nnh/PsfDjVBvfWvehUj/d0Vqq3CgLFp
         cA39Xe/TGNTCq3DrMvElHMJQauRt9Rhh0dSotzQK3UkTiFX/tvt54eSDAakbKSD1A8Tr
         6xOUS4N0kTM310oE0HB+mwfHwXcm+EwJW2MVxZnaBhd9ok92ekjXMILttpZr9LrThOp+
         rEzdeVKiOLOS5Tufk4W3UDpW/MdJaenY1aKtcFtT8jr0WjENeo8DrqTLOojXd0wdPaM/
         5AezbWTRR/hfV26Htp/ZcuJmoj7+5Tk/ADH5eSbgTZpSmBP4Bz7+mRf7xkU85QMJ7jid
         ZeeQ==
X-Gm-Message-State: ALoCoQkr8hE8U5U9awLNIw2OVQzwS0HD6RcxauJZbaAGw6ZWsYZ15JCP/yzVQsZq3C7QXwMkWPHH
X-Received: by 10.50.43.226 with SMTP id z2mr9714247igl.65.1436742667414;
        Sun, 12 Jul 2015 16:11:07 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id nj11sm2403471igb.19.2015.07.12.16.11.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:06 -0700 (PDT)
Subject: [PATCH 2/9] MIPS: Remove "weak" from platform_maar_init()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:04 -0500
Message-ID: <20150712231104.11177.69594.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

platform_maar_init() is defined in:

  - arch/mips/mm/init.c (where it is marked "weak")
  - arch/mips/mti-malta/malta-memory.c (without annotation)

The "weak" attribute on the platform_maar_init() extern declaration applies
to the platform-specific definition in arch/mips/mti-malta/malta-memory.c,
so both definitions are weak, and which one we get depends on link order.

Remove the "weak" attribute from the declaration.  That makes the malta
definition strong, so it will always be preferred if it is present.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-mips@linux-mips.org
---
 arch/mips/include/asm/maar.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
index 6c62b0f..b02891f 100644
--- a/arch/mips/include/asm/maar.h
+++ b/arch/mips/include/asm/maar.h
@@ -26,7 +26,7 @@
  *
  * Return:	The number of MAAR pairs configured.
  */
-unsigned __weak platform_maar_init(unsigned num_pairs);
+unsigned platform_maar_init(unsigned num_pairs);
 
 /**
  * write_maar_pair() - write to a pair of MAARs
