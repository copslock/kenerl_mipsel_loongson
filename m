Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 16:17:04 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45163 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903709Ab2FFORA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 16:17:00 +0200
Received: by wibhm14 with SMTP id hm14so4513056wib.6
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=F0GQkF328vovscqME/w+K3HSK/78VvCgkZAa2KZhIYg=;
        b=mo56qXmS/zPwI2XHXGw/tHahtZRvijhufqjrXGIBZiJQ2msNqS38M+Gd/jwo/EiMYL
         uT2ivy5gRmHymIX7F4kET7LM4W6xYGRhcFxoYGVCjUfu7lm1gRpVvWMgJaegSUhDrYoR
         9tmSPY7uSE/XmPZtPW2YEBEx8UKSy1xxYAemXL+uln6agUszpe9mQ625qxPhI1ekWGKg
         O9ygl2pQAnaTXZM7ET+HBed2N6mcVxi6BOTD3oAaUfgJg4D9gaESaC3M7IsKYDL34ApC
         xSS6KBLw3fazSsHYi2yOlkJOmnUhaY7svQ7cMUaJxXwNNz5HJuhxzoCsVTog5Cf5T+Td
         mcNA==
MIME-Version: 1.0
Received: by 10.216.198.1 with SMTP id u1mr17373729wen.92.1338992214659; Wed,
 06 Jun 2012 07:16:54 -0700 (PDT)
Received: by 10.194.1.100 with HTTP; Wed, 6 Jun 2012 07:16:54 -0700 (PDT)
Date:   Wed, 6 Jun 2012 22:16:54 +0800
Message-ID: <CAH+=+MHAPvLKuxKv4T+tzVFZd2-qG4=D+-h4aQNcW5ScFO8VnA@mail.gmail.com>
Subject: Symbol address in instructions is different from that in symbol table
From:   yan yan <clouds.yan@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
X-archive-position: 33575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clouds.yan@gmail.com
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

Hi, all:

    I'm new to mips.When I disassembled a linux vmlinux, I found
variable address referenced in instructions have a constant difference
64K respect to that in symbol table.
    For example, instruction/s want to reference a variable and
construct its address XXX3YYYY by lui and addui£¬but in system map, its
address is  actually XXX2YYYY. What happens?

Thanks
