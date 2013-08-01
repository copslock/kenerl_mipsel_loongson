Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 22:23:06 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64305 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822195Ab3HAUWwyKZuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Aug 2013 22:22:52 +0200
Received: by mail-ob0-f174.google.com with SMTP id wd6so4772670obb.19
        for <multiple recipients>; Thu, 01 Aug 2013 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=hqN9BTdYbvmokTrw3xrV3W8zwhwMiDt6Mr/2IpAk0n4=;
        b=GZ0Vuz5uncD6p7KUY3UdbXiloOgzQFVSuOWGg3CvhAtQWUtyutKoXf3442KOUIiUoc
         zB4TF1xGK7217+IafwM0RP7Mq++Xs5AVVh2WtiAepBx6DOFulx6HP6mBhWXBGPf1IilA
         yWcJMP/QLqUmoaokyeFzmBa7zgaiiVubgPSugqPet5Uwzdm7ETX8eMvuVOde4OERuPee
         dSZJtgstPxS1DtOXvngkCzaOvMYB/4OWkBvppI/Gpe+YqXD6g8edC6WToWDKPXzRkfmW
         IvhAh7jjXgCJBQKf9Pr3O9ZIRx6LQcE+Q23npjiY38Y5opx/26achBlPJalkcOikTA0d
         FPsg==
X-Received: by 10.182.237.82 with SMTP id va18mr2740640obc.0.1375388566421;
        Thu, 01 Aug 2013 13:22:46 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cp7sm4717129obb.0.2013.08.01.13.22.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 13:22:45 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r71KMh9Y004082;
        Thu, 1 Aug 2013 13:22:43 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r71KMfuF004081;
        Thu, 1 Aug 2013 13:22:41 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        Gleb Natapov <gleb@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] mips/kvm: Code cleanups for kvm_locore.S
Date:   Thu,  1 Aug 2013 13:22:32 -0700
Message-Id: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37422
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

These shouldn't be too controversial, they just clean things up
without changing the generated code.

More substantial patches will follow, but it seemed like a good idea
to clean this up first.

David Daney (3):
  mips/kvm: Improve code formatting in arch/mips/kvm/kvm_locore.S
  mips/kvm: Cleanup .push/.pop directives in kvm_locore.S
  mips/kvm: Make kvm_locore.S 64-bit buildable/safe.

 arch/mips/kvm/kvm_locore.S | 965 ++++++++++++++++++++++-----------------------
 1 file changed, 480 insertions(+), 485 deletions(-)

-- 
1.7.11.7
