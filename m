Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 23:52:47 +0200 (CEST)
Received: from sonic313-11.consmr.mail.ne1.yahoo.com ([66.163.185.34]:43510
        "EHLO sonic313-11.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994061AbeHBVwjTOPrq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 23:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1533246752; bh=ZTH1PhMWR4GySj9cj6UJLZAE8uW3gVGYn+0xVvXeW4w=; h=Date:From:Reply-To:To:Subject:References:From:Subject; b=QZt+9teU/c7LtIrkdYDJE964+tQXVvB6uLacw2wUetwk8C3vdCdGoVROwkTfd3rvQIAFHFRSQs3jQju6OjZx4xEK1F5+sq9Y7gnFtj7RM1DO9Mlh6zGum9DwU3DNFNzguMzSRjrU81FCneYk3AE3j4kY4GFILQ6d6MNaYIs1cXhIeCU5orDyhWh7GRtB8zYze9BL3OZiSdvo+L9ycJv3B2GhnDmcGYkHIpK1Jbe3qcHdF+jam94Lh/ugtBwt3ot008zgOFjvDJ7dx4KfaCEy5F9xBtScD5C2YFwrbN6//jWCiOoFyU6W9YVIdBY5RJW/wsASVNgdmiS2ABKzWVBoAQ==
X-YMail-OSG: DUwmEXQVM1mPWTlfBmZnK1DQmIclCyxelfdf3raCKcS2893gPQ9hA7j1TVxFfvO
 10.SkzeQVGVDXeeM.okchI0WUXWjN4MDbXlDAPK0w7UtZxRgz_ocBXPJwx.FFaFW9wreDKXzyDcv
 _R3AT8FsdL0YqRKgDpjaoA.n4m0S1Nw_tdmEhPOjJICmQcWIj0g1VwyOO0CKNRQxbyRjMXHYVEjx
 ECCCPJpEvESsen2t9cbJ1NK4zy2BRyiQYfjCxkwERvbY46CJlKLci44igkfHGbn0lhEOOSTdTvYW
 oZ3M4kqKojGFn6LUehoVPylGgZ4Ibb49ED3.x0dzFpyXf56EMCFmowbFLMjychEOfiaZ8lNV36ns
 pbRI4Japo4bszs5Jhh6jytM6kCGs7eG4RnhEfSDVS6KRgUkM_1NjpBg_ISck1b63GDlW6qLW1ih6
 hHjabiLfJ3ZfFWl3LaHeNDnVWV8reDEjohVrPIOrPkI8ZkBQBfvmLeq3CLQolja.j51S.Zei0wf5
 gtMyZWNiatxFTOp.WVjTgl62dWL7eNHqtEN8mOMfeEYqm_.P7gbZTamt9R.S0XEVRxANPJgDB5WI
 9XYBPxVV2FGgKo7CMYEShmY3B_dYn4tFwdGtm_jt_hXsVKGHjKwFRWj8HigZFFVXEiVe8J2KgLQk
 B3xqDHmcr.VX1TC0Q2bd8RgzUakkMBR_Zqrn9vlomSDc83zimdgpd14ZfU7ZqD0Opn4Nf7rJcTcw
 09anhYFOhGKFdiKx4u61x_KNWYSYikUd7XW7YuWLr4GArDI4F1jVYfclUxDHksFSL44UgUxLtGbn
 eFNmEdUjfTqsUeLIdruKureJnapD1j4y1SHB76psA6tNsAlUrcQ3BIUISq5pIfeGASfXc8jegZjo
 uea4bCjXGwXCFrB4.S7lvO7XAGs4pLhW1h57qWtKUnxpHZeAaIrm3Px5YTnTg2bB5qpzSMrBwPS5
 vvr.Qgow5M7xEfOY5cMl9GBil9tEBEgr0gaU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Aug 2018 21:52:32 +0000
Date:   Thu, 2 Aug 2018 21:52:31 +0000 (UTC)
From:   "A.W.C." <bluestream@ymail.com>
Reply-To: "A.W.C." <bluestream@ymail.com>
To:     <linux-mips@linux-mips.org>
Message-ID: <628114933.1303330.1533246751884@mail.yahoo.com>
Subject: disassembling raw MIPS binary
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <628114933.1303330.1533246751884.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.12206 YahooMailBasic Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0
Return-Path: <bluestream@ymail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bluestream@ymail.com
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

Hello,

I tried disassemble raw MIPS binary with opcodes on Linux machine. I run command

$ mips-linux-gnu-objdump -D -b bootloader.bin
mips-linux-gnu-objdump: 'a.out': No such file

how to solve this?

Regards,
