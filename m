Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 15:45:41 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:33376 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009898AbcANOpjdggie (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jan 2016 15:45:39 +0100
Received: from avionic-0020 (unknown [91.60.13.217])
        (Authenticated sender: albeu@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2706ED4813B;
        Thu, 14 Jan 2016 15:44:17 +0100 (CET)
Date:   Thu, 14 Jan 2016 15:45:32 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Alban <albeu@free.fr>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
Message-ID: <20160114154532.177ba6af@avionic-0020>
In-Reply-To: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
References: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Thu, 14 Jan 2016 11:20:57 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> The correct name for aliases node is "aliases" not "alias".
> 
> An overview of the "aliases" node usage can be found
> on the device tree usage page at devicetree.org [1].
> 
> Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
> 
> [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> [2] https://www.power.org/documentation/epapr-version-1-1/

Acked-by: Alban Bedel <albeu@free.fr>

> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
