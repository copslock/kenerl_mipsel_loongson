Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 04:44:13 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55975 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816383Ab3AaDoMMquxH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 04:44:12 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so1371611pbc.10
        for <linux-mips@linux-mips.org>; Wed, 30 Jan 2013 19:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mail-followup-to
         :mime-version:content-type:content-disposition:user-agent;
        bh=Pv5DIRve2P6bXa4CNfFyXQYkyjSYl5er2bBGmE0YMQs=;
        b=MilrvEf2onJqh6zKFG/9QEB/kIJbiAtxS0YJqe8KrFIvvWPUMqNVFqnQk3Z7XbZ+7y
         JXW9QCqbg62OCc9iwTmFVBcII57bRalsFP7GLz0IZQFQDWn40YAUsF1ThFseBngup2XR
         fO031kQIfoKdPDQLfkOBvIpYC1jVL1VaatXI9lEyuU0vDD9h2KZwykJq+wKrJfccWaqv
         IthCPCk1pm6DsM/PFWZFP+LFRbNK0V90gp1I2GFh6oJBxjrgs9kC/KtEaEKvxu/HRvyi
         jbfvdKaqgJ1AlwhKkOzWH28go6nUGRr52J3GYa9tFp7lk9cwEi6uQ2e5GYgU8NNBSSMw
         UVRQ==
X-Received: by 10.66.88.164 with SMTP id bh4mr16900960pab.41.1359603845466;
        Wed, 30 Jan 2013 19:44:05 -0800 (PST)
Received: from localhost ([159.226.43.42])
        by mx.google.com with ESMTPS id a4sm4076294paw.21.2013.01.30.19.44.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 19:44:04 -0800 (PST)
Date:   Thu, 31 Jan 2013 11:43:21 +0800
From:   yili0568@gmail.com
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: MIPS atomic_set_mask and atomic_clear_mask
Message-ID: <20130131034320.GA15216@gentoo.L3L6.loongson.cn>
Mail-Followup-To: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yili0568@gmail.com
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

Hello, everybody:
     Does MIPS need the functions atomic_set_mask and atomic_clear_mask?
     Or how can I implement these functions.
