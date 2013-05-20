Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 12:04:41 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:35411 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819780Ab3ETKEgSkr1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 12:04:36 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN3008FODBHREA0@mailout4.samsung.com> for
 linux-mips@linux-mips.org; Mon, 20 May 2013 19:04:29 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.41])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id 74.38.03969.B25F9915; Mon,
 20 May 2013 19:04:27 +0900 (KST)
X-AuditID: cbfee68f-b7f436d000000f81-ec-5199f52b6b52
Received: from epextmailer02 ( [203.254.219.152])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 13.77.30241.692F9915; Mon,
 20 May 2013 18:53:26 +0900 (KST)
Date:   Mon, 20 May 2013 09:53:26 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix compilation warning
To:     "david.daney@cavium.com" <david.daney@cavium.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130520095141724@eunb.song
Msgkey: 20130520095141724@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130520095141724@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <28060028.150781369043604705.JavaMail.weblogic@epml03>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42I5/e+Zpq7215mBBgfXiVlMmDqJ3YHR4+jK
        tUwBjFFcNimpOZllqUX6dglcGed3vWQqeMVZ0dK1jLWB8QhnFyMnh5CAikTL/++MILaEgInE
        tKuf2CBsMYkL99azQdQsY5RouwtX07h3KVMXIxdQfD6jxOneb6wgCRYBVYlD3xeC2WwC2hJv
        vzwAs4UF9CW+35rDBGKLCKRINJ5cCTaIWaBG4tvVfawQC+QlJp++zA5i8woISpyc+YQFYpmS
        xNxvM4B6OYDiyhKbOnwgwhISs6ZfYIWweSVmtD+FKpeTmPZ1DTOELS1xftYGRphfFn9/DBXn
        lzh2ewfYSJDeJ/eDYcbs3vwF6nUBialnDkK1qkv8uXEMqpVPYs3CtywwY3adWs4M03t/y1wm
        iK8UJaZ0P2SHsLUkvvzYx4buK14BJ4mbs7exTmBUnoUkNQtJ+ywk7chqFjCyrGIUTS1ILihO
        Si8y1itOzC0uzUvXS87P3cQISQv9OxjvHrA+xJgMjJGJzFKiyfnAtJJXEm9obGZkYWpiamxk
        bmlGmrCSOK9ai3WgkEB6YklqdmpqQWpRfFFpTmrxIUYmDk6pBsb2zG3KKsfZ7La4z9/Kfesd
        d2bwoqt81V+lt8Tmnj946RVP0KLlsfa17gVFDVfenWb8F6co3KCy4cqyguXsPrwsc6zX94al
        Crzy+JhnMqPk+1cDqxiuAwc2x/xPjFepXVOj/YmtadcVJ+eHZUy2789UvM1xVYrwt7kdx2Gj
        I8Pc4Ftfr7jllRJLcUaioRZzUXEiADTLo4MhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2DF3trzMDDVZ95reYMHUSuwOjx9GV
        a5kCGKMybDJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        pioplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWijQyM9YxMTfSMjA30TAxirQwNDIxMgaoS
        MjLO73rJVPCKs6KlaxlrA+MRzi5GTg4hARWJlv/fGUFsCQETica9S5kgbDGJC/fWs3UxcgHV
        zGeUON37jRUkwSKgKnHo+0Iwm01AW+LtlwdgtrCAvsT3W3PAmkUEUiQaT64EG8osUCPx7eo+
        Vohl8hKTT19mB7F5BQQlTs58wgKxTEli7rcZQL0cQHFliU0dPhBhCYlZ0y+wQti8EjPan0KV
        y0lM+7qGGcKWljg/awMjzM2Lvz+GivNLHLu9A2wkSO+T+8EwY3Zv/sIGYQtITD1zEKpVXeLP
        jWNQrXwSaxa+ZYEZs+vUcmaY3vtb5jJBfKUoMaX7ITuErSXx5cc+NnRf8Qo4SdycvY11AqPc
        LCSpWUjaZyFpR1azgJFlFaNoakFyQXFSeoWJXnFibnFpXrpecn7uJkZwinq2ZAdjwwXrQ4wC
        HIxKPLwCATMDhVgTy4orcw8xSnAwK4nwLv0CFOJNSaysSi3Kjy8qzUktPsSYDIy/icxSosn5
        wPSZVxJvaGxgbGhoaW5gamhkQZqwkjjvs1brQCGB9MSS1OzU1ILUIpgtTBycUg2MGj+E/k2q
        8Tnmriv6t1J1z9m50yesZ3i421dGQDknJFb/ugSv65XXU5VvKz8NOz/np+f8OatqXxlJ7s3b
        XltXY7Xq5FX+28mvv8lf/xu4zI3nc1ZNyvnE3A8/VPfoLlnTEJQypXz/psNPj4t+O7nkb1uz
        5w079+liamEr1s9Pvix44BxTy/zPH5VYijMSDbWYi4oTARg7zPuVAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eunb.song@samsung.com
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

DQpGaXggdGhlIGZvbGxvd2luZyBjb21waWxhdGlvbiB3YXJuaW5nOg0KDQptbS9wYWdlX2FsbG9j
LmM6IEluIGZ1bmN0aW9uICdmcmVlX3Jlc2VydmVkX2FyZWEnOg0KbW0vcGFnZV9hbGxvYy5jOjUx
NjI6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiAndmlydF90b19waHlzJyBtYWtlcyBw
b2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdA0KDQpTaWduZWQtb2ZmLWJ5OiBFdW5i
b25nIFNvbmcgPGV1bmIuc29uZ0BzYW1zdW5nLmNvbT4NCi0tLQ0KIGFyY2gvbWlwcy9pbmNsdWRl
L2FzbS9wYWdlLmggfCAgICAyICstDQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9hc20vcGFn
ZS5oIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL3BhZ2UuaA0KaW5kZXggZWMxY2E1My4uNDE2NDBm
MSAxMDA2NDQNCi0tLSBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9wYWdlLmgNCisrKyBiL2FyY2gv
bWlwcy9pbmNsdWRlL2FzbS9wYWdlLmgNCkBAIC0xOTcsNyArMTk3LDcgQEAgdHlwZWRlZiBzdHJ1
Y3QgeyB1bnNpZ25lZCBsb25nIHBncHJvdDsgfSBwZ3Byb3RfdDsNCiANCiAjZW5kaWYNCiANCi0j
ZGVmaW5lIHZpcnRfdG9fcGFnZShrYWRkcikJcGZuX3RvX3BhZ2UoUEZOX0RPV04odmlydF90b19w
aHlzKGthZGRyKSkpDQorI2RlZmluZSB2aXJ0X3RvX3BhZ2Uoa2FkZHIpCXBmbl90b19wYWdlKFBG
Tl9ET1dOKHZpcnRfdG9fcGh5cygoY29uc3Qgdm9sYXRpbGUgdm9pZCAqKShrYWRkcikpKSkNCiAN
CiBleHRlcm4gaW50IF9fdmlydF9hZGRyX3ZhbGlkKGNvbnN0IHZvbGF0aWxlIHZvaWQgKmthZGRy
KTsNCiAjZGVmaW5lIHZpcnRfYWRkcl92YWxpZChrYWRkcikJCQkJCQlcDQotLSANCjEuNy4wLjQN
Cg==
