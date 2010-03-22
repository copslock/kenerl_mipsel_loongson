Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 08:01:33 +0100 (CET)
Received: from mail-qy0-f173.google.com ([209.85.221.173]:51040 "EHLO
        mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491927Ab0CVHB3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Mar 2010 08:01:29 +0100
Received: by qyk4 with SMTP id 4so1273219qyk.24
        for <linux-mips@linux-mips.org>; Mon, 22 Mar 2010 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=RoRqYXQCGk7KMCCAS7LTw5Uy3n9/MtZN3KIvWiMnEdA=;
        b=l5gzE00y6XJVfi+/sbJzqd0AN3A+dMZZ0NLbIjw6Z6NXvdHS4+VSfYdIW2jarRiBZM
         MRVEVo0AklSyBpdYAi7ykJfrowbH5FuaLRaNK2HnzgOz7t5nlSGqRBLQflawRZFJxpYL
         407QMHgZleaM7yppiqHH6QV9c6pjYgki9jFgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=YKLwRsDmBmR8e3onpev3aKruRFYgacoADJDFLm+M3S1VmFXkC/Ck7moFj3JB08d9bJ
         IuCFpQ+4B80pomLnFhz2Et9nUcXt1kozz4vRRbVMNv7FGtkTidVNWBqQUlvL9DQwIuAj
         OX9NrNPJIbP406kEqPyarNwmznsnsdfFDbnHs=
MIME-Version: 1.0
Received: by 10.229.190.133 with SMTP id di5mr211493qcb.23.1269241281957; Mon, 
        22 Mar 2010 00:01:21 -0700 (PDT)
Date:   Mon, 22 Mar 2010 15:01:21 +0800
Message-ID: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
Subject: [BUG?] cavium cn56xx and dma_map_single warning
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I've got a strange dma error on my cavium cn56xx board.

......
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfbb8f000-0xfbb8ffff
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfb2ef000-0xfb2f0fff
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfb3de000-0xfb3defff
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfb3dd000-0xfb3ddfff
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfac28000-0xfac29fff
dma_map_single: Warning: Mapping memory address that might conflict
with devices 0xfad1a000-0xfad1bfff
.....

this error appeared when I plugged 4G or 8G ram on the board, if there
is only 2G ram on the board, the error never happened.

an adaptec 3405 pci-e raid card is plugged on the board, and a
harddisk attached. the program i am running is a postgresql server
with more than 20 million record, so do a count(*) will let postgresql
consume almost all of the available memory. while there is 4G ram, the
'free' command reported that the free memory is below 18M.

then the error kept printing on the console for a while, then kernel panic.

the warning message is come from arch/mips/cavium-octeon/dma-octeon.c

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/cavium-octeon/dma-octeon.c;h=be531ec1f2064b590b58dfe8b4db4f5534999bab;hb=HEAD

i tried several raid card from different producer, including LSI and
Adaptec. the same error always happened while there are more than or
equal to 4G memory on the board.

Would you please give some advice on this issue? any help will be appreciated.

Thanks.

Zhuang Yuyao
