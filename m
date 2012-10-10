Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 09:32:58 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:40457 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870357Ab2JJHcygdrX- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 09:32:54 +0200
Received: by mail-oa0-f49.google.com with SMTP id l10so207458oag.36
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2012 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=aMESkDqnAdIOchS4LR+7+ZxaGvncd2suA6oQwrg4Cag=;
        b=JcA2GySNMMupQuRRYMUiLG8SjkF1mxxg6NvOhx2C6C9VMCUmw6rmRFfM87wx9uxacP
         SoFhMBe7fxanjvlCJIp1Aah3cemSmicHJDiJPOxKtMuamQrnqQWQ8hnvnlrCiRfd9SPy
         UJoWGWY72nKW5BWq0/uLY0UhjLkscEmsaHhtnYYuDDWVMudI3Es+MbaC8zpeI23efVMX
         ARsFgHjKSP3uLIw38XAkUu9eNe3zBCou0Cj2TLxIXsmEhxCVa8RJu5UZn8fou2NoGR0q
         nJPz2irdhoacXv+a3ct5RTsIonzXJYMBHvqkPLXOl7TzTGNSnQXB/AlABs9VAf3y7oIk
         zKkQ==
MIME-Version: 1.0
Received: by 10.60.32.176 with SMTP id k16mr11273983oei.130.1349850767919;
 Tue, 09 Oct 2012 23:32:47 -0700 (PDT)
Received: by 10.60.66.4 with HTTP; Tue, 9 Oct 2012 23:32:47 -0700 (PDT)
Date:   Wed, 10 Oct 2012 08:32:47 +0200
Message-ID: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
Subject: 2GB userspace limitation in ABI N32
From:   Ronny Meeus <ronny.meeus@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ronny.meeus@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello

I have a legacy application that we want to port to a MIPS (Cavium)
architecture from a PPC based one.
The board has 4GB memory of which we actually need almost 3GB in
application space. On the PPC this is no issue since the split
user/kernel is 3GB/1GB.
We have to use the N32 ABI Initial tests on MIPS showed me the
user-space limit of 2GB.
We do not want to port the application to a 64bit

Now the question is: are there any workarounds, tricks existing to get
around this limitation?
I found some mailthreads on this subject (n32-big ABI -
http://gcc.gnu.org/ml/gcc/2011-02/msg00278.html,
http://elinux.org/images/1/1f/New-tricks-mips-linux.pdf) but is looks
like this is not accepted by the community. Is there any process
planned or made in this area?

Thanks

---
Ronny
