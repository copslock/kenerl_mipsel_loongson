Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 11:59:22 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:60342 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819780Ab3ETJ7SME5QJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 11:59:18 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN300CO5CXNN4A0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Mon, 20 May 2013 18:59:08 +0900 (KST)
Received: from epcpsbgx4.samsung.com ( [203.254.230.41])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id 83.E3.29708.1D3F9915; Mon,
 20 May 2013 18:58:41 +0900 (KST)
X-AuditID: cbfee690-b7f6f6d00000740c-3b-5199f3d18850
Received: from epextmailer03 ( [203.254.219.153])
        by epcpsbgx4.samsung.com (EPCPMTA) with SMTP id 68.86.30241.A80F9915; Mon,
 20 May 2013 18:44:42 +0900 (KST)
Date:   Mon, 20 May 2013 09:44:42 +0000 (GMT)
From:   EUNBONG SONG <eunb.song@samsung.com>
Subject: [PATCH] mips: Fix compilation warning
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: eunb.song@samsung.com
MIME-version: 1.0
X-MTR:  20130520093721431@eunb.song
Msgkey: 20130520093721431@eunb.song
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130520093721431@eunb.song
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
Content-transfer-encoding: base64
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <151291.150571369043081270.JavaMail.weblogic@epml03>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t8zTd03n2cGGkx+JmUxYeokdgdGj6Mr
        1zIFMEZx2aSk5mSWpRbp2yVwZdz4+pq94A1XRe/5T8wNjEe4uhg5OYQEVCRa/n9nBLElBEwk
        bk+YB2WLSVy4t56ti5ELqGYZo8ShV1PYYIom3PnJCJGYzyixa856sASLgKrEv8t7wLrZBLQl
        3n55wApiCwvoSbxfPxUsLiKQIrFz2UFmEJtZoEai++9iRogr5CUmn77MDmLzCghKnJz5hAVi
        mZLEs1srGSHiyhLf3kxlhYhLSMyafgHK5pWY0f4Uql5OYtrXNcwQtrTE+Vkb4L5Z/P0xVJxf
        4tjtHUxdjBxgvU/uB8OM2b35C9SPAhJTzxyEalWX2NY8G2o8n8SahW9ZYMbsOrWcGab3/pa5
        TBBvKUpM6X7IDmFrSXz5sY8N3Vu8Ag4SG5sWMk9gVJ6FJDULSfssJO3IahYwsqxiFE0tSC4o
        TkovMtErTswtLs1L10vOz93ECEkNE3Yw3jtgfYgxGRglE5mlRJPzgaklryTe0NjMyMLUxNTY
        yNzSjDRhJXFe9RbrQCGB9MSS1OzU1ILUovii0pzU4kOMTBycUg2MWTtXsor+cXg2WYLhzKee
        zcK+opf2sZ/sfrppn+7zgqvV4n8/BOXXavrcXL63KW1D06U+zoT1h3lvtggYyDju2Gybaa3F
        OlNOJP/B589Wk+Q73cWuzd06z3zl4z6G3PIeg7X9vhnJwep31m1q2XIny3n/iZCdm8Nv8PUG
        5Z9Tfvre49Rkpg07lViKMxINtZiLihMBsQirGSMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5/e/2TN2Ln2cGGrz6xGIxYeokdgdGj6Mr
        1zIFMEZl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        TVVSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CpFGxkY6xmZmugZGRvomRjEWhkaGBiZAlUl
        ZGTc+PqaveANV0Xv+U/MDYxHuLoYOTmEBFQkWv5/ZwSxJQRMJCbc+Qlli0lcuLeerYuRC6hm
        PqPErjkgDicHi4CqxL/Le8CK2AS0Jd5+ecAKYgsL6Em8Xz8VLC4ikCKxc9lBZhCbWaBGovvv
        YkaIZfISk09fZgexeQUEJU7OfMICsUxJ4tmtlYwQcWWJb2+mskLEJSRmTb8AZfNKzGh/ClUv
        JzHt6xpmCFta4vysDXBHL/7+GCrOL3Hs9g6mLkYOsN4n94Nhxuze/IUNwhaQmHrmIFSrusS2
        5tlQ4/kk1ix8ywIzZtep5cwwvfe3zGWCeEtRYkr3Q3YIW0viy499bOje4hVwkNjYtJB5AqPc
        LCSpWUjaZyFpR1azgJFlFaNoakFyQXFSeoWJXnFibnFpXrpecn7uJkZwknq2ZAdjwwXrQ4wC
        HIxKPLwCATMDhVgTy4orcw8xSnAwK4nwRncDhXhTEiurUovy44tKc1KLDzEmAyNwIrOUaHI+
        MIHmlcQbGhsYGxpamhuYGhpZkCasJM77rNU6UEggPbEkNTs1tSC1CGYLEwenVAMjg3CXNYf9
        CtZ7iRXyav++H9s6ZaoUe/CBHS5cYX57hSdaGp2eqvRAZKPfu4QZ/rErvZhOMM31LThwYMck
        4a+/GycH3DPZFMG3NFJvQ4ap2/GUqa9Xrqzuc05cc7to1ewpWWe1S9uUP/9QqNcMYz3p4XuT
        203HOfLo++jicF212Qc7i2J8oi4osRRnJBpqMRcVJwIAJZN80JYDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Return-Path: <eunb.song@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36481
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
b2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdA0KL2hvbWUvZWJzb25nL2JhY2t1cC9s
aW51eF9naXQvbGludXgvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lvLmg6MTE5OiBub3RlOiBleHBl
Y3RlZCAnY29uc3Qgdm9sYXRpbGUgdm9pZCAqJyBidXQgYXJndW1lbnQgaXMNCm9mIHR5cGUgJ2xv
bmcgdW5zaWduZWQgaW50Jw0KLS0tDQogYXJjaC9taXBzL2luY2x1ZGUvYXNtL3BhZ2UuaCB8ICAg
IDIgKy0NCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9wYWdlLmggYi9hcmNoL21pcHMv
aW5jbHVkZS9hc20vcGFnZS5oDQppbmRleCBlYzFjYTUzLi40MTY0MGYxIDEwMDY0NA0KLS0tIGEv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL3BhZ2UuaA0KKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNt
L3BhZ2UuaA0KQEAgLTE5Nyw3ICsxOTcsNyBAQCB0eXBlZGVmIHN0cnVjdCB7IHVuc2lnbmVkIGxv
bmcgcGdwcm90OyB9IHBncHJvdF90Ow0KIA0KICNlbmRpZg0KIA0KLSNkZWZpbmUgdmlydF90b19w
YWdlKGthZGRyKQlwZm5fdG9fcGFnZShQRk5fRE9XTih2aXJ0X3RvX3BoeXMoa2FkZHIpKSkNCisj
ZGVmaW5lIHZpcnRfdG9fcGFnZShrYWRkcikJcGZuX3RvX3BhZ2UoUEZOX0RPV04odmlydF90b19w
aHlzKChjb25zdCB2b2xhdGlsZSB2b2lkICopKGthZGRyKSkpKQ0KIA0KIGV4dGVybiBpbnQgX192
aXJ0X2FkZHJfdmFsaWQoY29uc3Qgdm9sYXRpbGUgdm9pZCAqa2FkZHIpOw0KICNkZWZpbmUgdmly
dF9hZGRyX3ZhbGlkKGthZGRyKQkJCQkJCVwNCi0tIA0KMS43LjAuNA0K
