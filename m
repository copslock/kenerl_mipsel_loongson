Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:33:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23497
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025227AbaHWShC4hFrq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 20:37:02 +0200
X-IronPort-AV: E=Sophos;i="5.04,387,1406584800"; 
   d="scan'208";a="76200902"
Received: from palace.rsr.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Aug 2014 20:36:57 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     linux-mips@linux-mips.org
Cc:     joe@perches.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/7] delete double assignment
Date:   Sat, 23 Aug 2014 20:33:21 +0200
Message-Id: <1408818808-18850-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

These patches fix cases where there are two adjacent assignments to the
same location.  In practice, many such occurrences appear to be
intentional, eg to initialize volatile memory, but these cases do not seem
to fall into that category.

The complete semantic match that finds these problems is as follows:

// <smpl>
@r@
expression i,f;
position p1,p2;
@@

(
 i = <+...f(...)...+>;
|
 i |= <+...f(...)...+>;
|
 i &= <+...f(...)...+>;
|
 i += <+...f(...)...+>;
|
 i -= <+...f(...)...+>;
|
 i *= <+...f(...)...+>;
|
 i /= <+...f(...)...+>;
|
 i %= <+...f(...)...+>;
|
 i ^= <+...f(...)...+>;
|
 i <<= <+...f(...)...+>;
|
 i >>= <+...f(...)...+>;
|
 i@p1 = ...;
|
 i@p1 |= ...;
|
 i@p1 &= ...;
|
 i@p1 += ...;
|
 i@p1 -= ...;
|
 i@p1 *= ...;
|
 i@p1 /= ...;
|
 i@p1 %= ...;
|
 i@p1 ^= ...;
|
 i@p1 <<= ...;
|
 i@p1 >>= ...;
|
 i@p1 ++;
|
 ++i@p1;
|
 i@p1 --;
|
 --i@p1;
)
(
 i = <+...i...+>;
|
 i = <+...f(...)...+>;
|
 i@p2 = ...;
)

@@
expression i,j,f;
position r.p1,r.p2;
@@

(
 (<+...i@p1...+>);
)
(
 (<+...\(j++\|++j\|j--\|--j\|f(...)\)...+>) = ...;
|
*i@p2 = ...;
)
// </smpl>
